###
Execution class - API Usage
=================================================
This is an object oriented implementation around the core `process.spawn`
command and alternatively ssh connections.
###


# Node Modules
# -------------------------------------------------
debug = require('debug')('exec')
chalk = require 'chalk'
async = require 'async'
fspath = require 'path'
EventEmitter = require('events').EventEmitter
# include alinex modules
util = require 'alinex-util'
config = require 'alinex-config'
ssh = require 'alinex-ssh'
# internal helpers
schema = require './configSchema'
check = require './check'


# General setup
# -------------------------------------------------

# The load should be near the sys and usr time the process needs.
#
# @type {Float} as fraction of what a command will add as load
DEFAULT_LOAD = 0.001

# Counter for unique object IDs which is used as internal identifier for each
# execution.
#
# @type {Integer} with the last used id
objectId = 0


class Exec extends EventEmitter

  # Class Properties
  # -------------------------------------------------

  # Collection of vital data per host for each interval.
  #
  # @type {Object} vital signs
  @vital: {}

  # Methods for special commands to calculate start load depending on given args
  # array as a hint you may use the sys and usr time which you get then running
  # the process but only within a second it may be more than 1.0 if running on
  # multi core
  #
  # @param {Array} [args] arguments for command
  # @return {Float} other weight as the {@link DEFAULT_LOAD}
  @load:
    exiftool: -> 0.008

  # The queue of jobs which are listed under 'host'->'priority' lists and it also
  # contains the corresponding callbacks
  #
  # @type {Object} deep list of jobs
  @queue: {}

  # Current queue size to help analyze the load.
  #
  # @type {Object} containing the information:
  # - `total` - `Integer` number of all jobs in queue
  # - `host` - `Object<Integer>` number of jobs waiting on each host
  # - `priority` - `Object<Integer>` number of jobs waiting in each priority
  @queueCounter:
    total: 0
    host: {}
    priority: {}


  ###
  Class Initialization
  -------------------------------------------------------------
  ###

  ###
  Set the modules config paths and validation schema.

  @name Exec.setup
  @param {Function(<Error>)} cb callback with possible error
  ###
  @setup: util.function.once this, (cb) ->
    # set module search path
    config.register false, fspath.dirname __dirname
    # add schema for module's configuration
    config.setSchema '/exec', schema, ->
      ssh.setup cb

  ###
  Set the modules config paths, validation schema and initialize the configuration.

  @name Exec.init
  @param {Function(<Error>)} cb callback with possible error
  ###
  @init: util.function.once this, (cb) ->
    debug "initialize"
    # set module search path
    @setup (err) ->
      return cb err if err
      config.init cb


  # Worker process
  # ---------------------------------------------------------
  # The worker is a process which is started if a queue exists and work while the
  # queue is not done. It will run all the tasks by priority on all hosts.

  # Flag if a worker process is already started or running.
  #
  # @type {Boolean} flag if an worker already exists
  @workerRunning: false

  # The worker itself.
  #
  # @name Exec.worker
  # @type {Function}
  @worker: =>
    unless (hosts = Object.keys @queue).length
      @workerRunning = false
      return
    debug chalk.grey """
    worker started: #{@queueCounter.total} total tasks waiting / \
    hosts: #{util.inspect @queueCounter.host} / \
    priority: #{util.inspect @queueCounter.priority}
    """
    async.each hosts, (host, cb) =>
      prios = Object.keys @queue[host]
      prios.reverse()
      async.eachSeries prios, (prio, cb) =>
        list = @queue[host][prio]
        return cb() unless list.length
        debug chalk.grey "worker running jobs for #{host} with #{prio} priority"
        mark = []
        async.forever (cb) =>
          return cb true unless list.length
          # check if next process is already done in this round
          return cb true if list[0][0].id in mark
          # check
          @vitalCheck host, prio, DEFAULT_LOAD, (err) =>
          # stop if check failed
            return cb true unless list.length
            return cb err if err
            # get first entry
            [exec, ocb] = list.shift()
            # reduce counter
            @queueCounter.total--
            @queueCounter.host[host]--
            @queueCounter.priority[prio]--
            # exec run
            mark.push exec.id
            exec.run ocb
            setTimeout cb, 100
        , (err) =>
          debug chalk.grey "worker finished round"
          delete @queue[host][prio] unless list.length
          cb err
      , (err) =>
        delete @queue[host] unless Object.keys(@queue[host]).length
        cb err
    , =>
      # stop worker if completely done
      unless Exec.queueCounter.total
        @workerRunning = false
        return
      # if not rerun it later
      setTimeout @worker, config.get 'exec/retry/queue/interval'


  ###
  Easy call to directly run execution in one statement.

  @name Exec.run
  @param {Object} setup the job definition like in the constructor
  @param {Function(<Error>, <Exec>)} cb callback with possible error
  and the execution job which was used
  ###
  @run: (setup, cb) ->
    Exec.init (err) ->
      return cb err if err
      proc = new Exec setup
      proc.run cb

  ###
  Close remote connections

  @name Exec.close
  ###
  @close: ->
    lib = require './ssh'
    lib.closeAll()


  ###
  Instance Methods
  --------------------------------------------------
  ###

  ###
  Create a new execution object to specify and call later.

  @name Exec
  @param {Object} setup the job definition
  @return {Exec} object containing the following properties:
  - `id` - `Integer` unique id of element
  - `setup` - `Object` configuration of job
    - `remote` - `String|Object|Array<Object>` ssh connection
    - `cmd` - `String` command to execute (with optional parameters)
    - `args` - `Array<String>` list of command arguments
    - `priority` - `String` priority to use
  - `server` - `Object` server to run on
  - `name` - `String` connection URI for debug messages
  - `result` - `Object`
    - `start` - `Date` of execution start
    - `end` - `Date` of execution end
  ###
  constructor: (@setup) ->
    # ge
    t identifiers
    @id = ++objectId
    @server = @setup.remote ? {host: 'localhost'}
    @server = @server[0] if Array.isArray @server
    @name = chalk.grey "#{@server.host}##{@id}"
    # set priority
    conf = config.get '/exec/priority'
    @setup.priority ?= conf.default
    unless conf.level[@setup.priority]
      debug chalk.red "Undefined priority #{@setup.priority} - using default"
      @setup.priority = conf.default
    debug "#{@name} created new instance with #{@setup.priority} priority"

  ###
  Start execution

  @name exec.run
  @param {Function(<Error>)} cb callback with possible error
  ###
  run: (cb) ->
    return cb new Error "Already running." if @result?.start and not @result.end
    # optimize cmd - extract arguments
    if ~@setup.cmd.indexOf ' '
      parts = @setup.cmd.match ///
      (?:         # non-capturing group
        [^\s"]+   # anything that's not a space or a double-quote
        |         # or
        "[^"]*"   # zero or more characters in double-quotes
        |         # or
        '[^']*'   # zero or more characters in single-quotes
      )+          # each match is one or more of the things described in the group
      ///g
      if parts.length > 1
        @setup.cmd = parts.shift()
        @setup.args = parts.concat @setup.args ? []
    # check existing vital data
    Exec.vitalCheck.call this, (err, res) =>
#    Exec.vitalCheck @host, @setup.priority, load, (err, res) =>
      return cb err if err
      return @addQueue res, cb if res
      # add load to calculate startlimit
      Exec.vital[@server.host].startload += load
      # run locally or remote
      lib = require if @server.host is 'localhost' then './spawn' else './ssh'
      lib.run.call this, (err) =>
        if err
          debug "#{@name} failed with #{err}"
          return cb err
        # success
        @checkResult cb

  # This will not only check the vital data but also select the server to use
  # if a group is given.
  #
  # @name exec.vitalCheck
  # @param {Function(<Error>)} cb callback with possible error
  # if anything prevents the process from running
  vitalCheck: (cb) ->
    # get information
    load = Exec.load[@setup.cmd]?(@setup.args) ? DEFAULT_LOAD
    conf = config.get '/exec'
    prio = conf.priority.level[@setup.priority]
    # prevent vital check if no restrictions
    unless prio.maxCpu? or prio.minFreemem? or prio.maxLoad?
      # shuffle and use first
      if Array.isArray @setup.remote
        util.array.shuffle @setup.remote
        @server = @setup.remote[0]
      # but only on local run
      return cb null, false if @server.host is 'localhost'
    # resolve server list
#    serverlist = if typeof setup is 'string'
#      if @server.host is 'localhost'
#        return null #[@server]
#      list = config.get "/exec/group/#{setup.remote}"
#      if list
#        return list.map (e) -> config.get "/ssh/server/#{e}"
#      else
#        return [config.get "/ssh/server/#{setup.remote}"]
#    else if Array.isArray @setup.remote
#      @setup.remote
#    else
#      [@setup.remote]
    # really check the load of the list
    date = Math.floor new Date().getTime() / conf.retry.vital.interval
    lib = require if @server.host is 'localhost' then './spawn' else './ssh'
    # collect vital data
    async.each serverlist, (server, cb) =>
#    lib.vital host, vital, date, (err) ->
      lib.vital exec, date, (err, vital) =>
        return cb() if err
        @vital[@server.host] = vital
        @server.vital = vital
        cb()
    , (err) ->
      # sort list by load (asc)
      serverlist = serverlist.filter (e) => @vital[e.host]
      serverlist = util.array.sortBy serverlist, 'vital'
      # select connection to use
      @server = serverlist[0]
      vital = @vital[@server.host] ?= {}
      # check startload
      if vital.startload and vital.startload + load > vital.startmax
        return cb null, new Error "The maximum load to start per interval would be exceeded
        with this process at #{@server.host}"
      # error already detected
      return cb null, vital.error[@setup.priority] if vital.error[@setup.priority]?
      # check for new error
      vital.error[@setup.priority] = if prio.maxCpu? and vital.cpu > prio.maxCpu
        new Error "The CPU utilization of #{Math.round vital.cpu * 100}% is above
        #{Math.round prio.maxCpu * 100}% allowed for #{@setup.priority} priority at #{@server.host}"
      else if prio.minFreemem? and vital.freemem < prio.minFreemem
        new Error "The free memory of #{Math.round vital.freemem * 100}% is below
        #{Math.round prio.minFreemem * 100}% allowed for #{@setup.priority} priority at #{@server.host}"
      else if prio.maxLoad?[0]? and vital.load[0] > prio.maxLoad[0]
        new Error "The average short load of #{Math.round vital.load[0], 2} is above
        #{Math.round prio.maxLoad[0] * 100}% allowed for #{@setup.priority} priority at #{@server.host}"
      else if prio.maxLoad?[1]? and vital.load[1] > prio.maxLoad[1]
        new Error "The average medium load of #{Math.round vital.load[1], 2} is above
        #{Math.round prio.maxLoad[1] * 100}% allowed for #{@setup.priority} priority at #{@server.host}"
      else if prio.maxLoad?[2]? and vital.load[2] > prio.maxLoad[2]
        new Error "The average long load of #{Math.round vital.load[2], 2} is above
        #{Math.round prio.maxLoad[2] * 100}% allowed for #{@setup.priority} priority at #{@server.host}"
      else false
      cb null, vital.error[priority]

  # If direct execution is not possible add this task to the queue
  #
  # @param {Error} err explaining why it is not possible to run
  # @param {Function} cb which is called after execution is finally done
  addQueue: (err, cb) ->
    host = @setup.remote ? 'localhost'
    if err
      debug chalk.grey "#{@name} add to queue because: #{err.message}"
    else
      debug chalk.grey "#{@name} add to queue because other processes are waiting"
    unless Exec.workerRunning
      Exec.workerRunning = true
      setTimeout Exec.worker, config.get 'exec/retry/queue/interval'
    Exec.queue[host] ?= {}
    Exec.queue[host][@setup.priority] ?= []
    Exec.queue[host][@setup.priority].push [this, cb]
    Exec.queueCounter.total++
    Exec.queueCounter.host[host] ?= 0
    Exec.queueCounter.host[host]++
    Exec.queueCounter.priority[@setup.priority] ?= 0
    Exec.queueCounter.priority[@setup.priority]++


  # Result Analyzation
  # ------------------------------------------------

  # Run defined checks on result.
  #
  # @param {Function(<Error>, <Exec>)} cb with possible error and the object itself
  checkResult: (cb) ->
    # find check to use
    list = @setup.check ? {
      noExitCode:
        retry: @setup.retry?.times
    }
    # run checks
    for n, v of list
      return cb new Error "Unknown check function #{n} in Exec" unless check[n]?
      v.args = [v.args] unless Array.isArray v.args
      err = check[n].apply this, v.args ? null
      continue unless err
      debug chalk.magenta "#{@name} #{n}: #{err.message}"
      # got an error
      @result.error = err
      if v.retry
        times = @setup.retry.times ? @conf.retry.error.times
        if @tries?.length >= times
          debug chalk.red "#{@name} reached #{times} retries - giving up"
          return cb err, this
        return setTimeout =>
          # store last try
          @tries ?= []
          @tries.push
            process: @process
            result: @result
          # run again
          this.run cb
        , @setup.retry.interval ? @conf.retry.error.interval
      return cb err, this
    # everything ok, go on
    debug "#{@name} succeeded"
    cb null, this

  # @param {Object} data the result data from the process
  # @return {String} whole output on the STDOUT console of the process
  stdout: (data) ->
    data ?= @result
    return data.stdout if data.stdout
    stdout = data.lines
    .filter (e) -> e[0] is 1
    .map (e) -> e[1]
    .join '\n'
    data.stdout = stdout if data.code?
    stdout

  # @param {Object} data the result data from the process
  # @return {String} whole output on the STDERR console of the process
  stderr: (data) ->
    data ?= @result
    return data.stderr if data.stderr
    stderr = data.lines
    .filter (e) -> e[0] is 2
    .map (e) -> e[1]
    .join '\n'
    data.stderr = stderr if data.code?
    stderr


module.exports = Exec
