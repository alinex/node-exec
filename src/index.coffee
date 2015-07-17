# Execution class
# =================================================
# This is an object oriented implementation around the core `process.spawn`
# command and alternatively ssh connections.

# Node Modules
# -------------------------------------------------

# include base modules
debug = require('debug')('exec')
chalk = require 'chalk'
fspath = require 'path'
os = require 'os'
EventEmitter = require('events').EventEmitter
# include alinex modules
config = require 'alinex-config'
async = require 'alinex-async'
# internal helpers
schema = require './configSchema'
spawn = require './spawn'
check = require './check'

# General setup
# -------------------------------------------------

# The load should be near the sys and usr time the process needs.
DEFAULT_LOAD = 0.001

# counter for unique object IDs
objectId = 0

# Class definition
# -------------------------------------------------
class Exec extends EventEmitter

  # ### Vital Data

  # collection of vital data per host for each interval
  @vital: {}

  # methods for special commands to calculate start load depending on given args
  # array as a hint you may use the sys and usr time which you get then running
  # the process but only within a second it may be more than 1.0 if running on
  # multi core
  @load:
    exiftool: -> 0.008

  # ### Queue

  # the queue itself jobs are listed under 'host'->'priority' lists and also
  # contains the corresponding callbacks
  @queue: {}

  # for statistical information this short summaries will help
  @queueCounter:
    total: 0
    host: {}
    priority: {}

  # ### Initialization

  # set the modules config paths, validation schema and initialize the configuration
  @init: async.once this, (cb) ->
    debug "initialize"
    # set module search path
    config.register false, fspath.dirname __dirname
    # add schema for module's configuration
    config.setSchema '/exec', schema, (err) ->
      return cb err if err
      config.init cb

  # ### Worker

  # The worker is a process which is started if a queue exists and work while the
  # queue is not done. It will run all the tasks by priority on all hosts.

  # flag if a worker process is already started or running
  @workerRunning: false

  # the worker itself
  @worker: =>
    unless (hosts = Object.keys @queue).length
      @workerRunning = false
      return
    debug chalk.grey """
    worker started: #{@queueCounter.total} total tasks waiting
    hosts: #{@queueCounter.host}
    priority: #{@queueCounter.priority}
    """
#    #####################################################################
#    util = require 'util'
#    console.log 'WORKER', util.inspect @queue, {depth: null}
#    #####################################################################
    async.each hosts, (host, cb) =>
      prios = Object.keys @queue[host]
      prios.reverse()
#      console.log 'HOST', host, prios
      async.eachSeries prios, (prio, cb) =>
        list = @queue[host][prio]
        return cb() unless list.length
        debug chalk.grey "worker running jobs for #{host} with #{prio} priority"
#        async.each list, ([exec, ocb], cb) =>
        mark = []
        async.forever (cb) =>
#          console.log '?? loop', list.length
          return cb true unless list.length
          # check if tnext process is already done in this round
          return cb true if list[0][0].id in mark
          # check
          @vitalCheck host, prio, DEFAULT_LOAD, (err) =>
          # stop if check failed
            return cb true unless list.length
            return cb err if err
            # get first entry
            [exec, ocb] = list.shift()
#            console.log '++ loop', list.length
            # reduce counter
            @queueCounter.total--
            @queueCounter.host[host]--
            @queueCounter.priority[prio]--
            # exec run
            mark.push exec.id
#            console.log '-- exec call', exec.id
            exec.run ocb
            setTimeout cb, 100
        , (err) =>
#          console.log '-- prio done'
          debug chalk.grey "worker finished round"
          delete @queue[host][prio] unless list.length
          cb()
      , (err) =>
#        console.log '-- host done'
        delete @queue[host] unless Object.keys(@queue[host]).length
        cb()
    , =>
#      console.log '-- all done'
      # stop worker if completely done
      unless Exec.queueCounter.total
        @workerRunning = false
        return
      # if not rerun it later
#      console.log '>>>>>> recall worker'
      setTimeout @worker, config.get 'exec/retry/queue/interval'

  # get and check vital data - this will return an error if anything prevents
  # from running the process
  @vitalCheck: (host, priority, load, cb) ->
    conf = config.get '/exec'
    vital = @vital[host] ?=
      startmax: conf.retry.vital.startload * conf.retry.vital.interval / 1000 * os.cpus().length
    # get vital data
    date = Math.floor new Date().getTime() / conf.retry.vital.interval
    spawn.vital vital, date, (err) ->
      return cb err if err
      # check startload
      if vital.startload and vital.startload + load > vital.startmax
        return cb new Error "The maximum load to start per interval would be exceeded
        with this process at #{host}"
      # error already detected
      return cb vital.error[priority] if vital.error[priority]?
      # check for new error
      prio = conf.priority.level[priority]
      vital.error[priority] = if prio.maxCpu? and vital.cpu > prio.maxCpu
        new Error "The CPU utilization of #{Math.round vital.cpu * 100}% is above
        #{Math.round prio.maxCpu * 100}% allowed for #{priority} priority at #{host}"
      else if prio.minFreemem? and vital.freemem < prio.minFreemem
        new Error "The free memory of #{Math.round vital.freemem * 100}% is below
        #{Math.round prio.minFreemem * 100}% allowed for #{priority} priority at #{host}"
      else if prio.maxLoad?[0]? and vital.load[0] > prio.maxLoad[0]
        new Error "The average short load of #{Math.round vital.load[0], 2} is above
        #{Math.round prio.maxLoad[0] * 100}% allowed for #{priority} priority at #{host}"
      else if prio.maxLoad?[1]? and vital.load[1] > prio.maxLoad[1]
        new Error "The average medium load of #{Math.round vital.load[1], 2} is above
        #{Math.round prio.maxLoad[1] * 100}% allowed for #{priority} priority at #{host}"
      else if prio.maxLoad?[2]? and vital.load[2] > prio.maxLoad[2]
        new Error "The average long load of #{Math.round vital.load[2], 2} is above
        #{Math.round prio.maxLoad[2] * 100}% allowed for #{priority} priority at #{host}"
      else false
      cb vital.error[priority]

  # ### Start execution

  # easy call to directly run execution in one statement
  @run: (setup, cb) ->
    Exec.init (err) ->
      return cb err if err
      proc = new Exec setup
      proc.run cb

  # create a new execution object to specify and call later
  constructor: (@setup) ->
    @id = ++objectId
    host = 'localhost'
    @name = chalk.grey "#{host}##{@id}:"
    # set priority
    prio = config.get 'exec/priority'
    @setup.priority ?= prio.default
    unless prio.level[@setup.priority]
      debug chalk.red "Undefined priority #{@setup.priority} - using default"
      @setup.priority = prio.default
    debug "#{@name} created new instance with #{@setup.priority} priority"

  # start execution
  run: (cb) ->
    host = @setup.remote ? 'localhost'
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
        @setup.args = parts.concat args ? []
    # if queue for host exists add this
    return @addQueue cb if Exec.queueCounter.host[host]
    # check existing vital data
    @conf ?= config.get '/exec'
    load = Exec.load[@setup.cmd]?(@setup.args) ? DEFAULT_LOAD
    Exec.vitalCheck host, @setup.priority, load, (err) =>
      return @addQueue err, cb if err
      # add load to calculate startlimit
      Exec.vital[host].startload += load
#      console.log Exec.vital ############################################################
      debug "#{@name} with #{@setup.priority} priority at #{host}"
      # check for local or remote
      if @setup.remote
        throw new Error "Remote execution using ssh not implemented, yet."
      # run locally
      spawn.run.call this, (err) =>
        if err
          debug "#{@name} failed with #{err}"
          return cb err
        # success
        @checkResult cb

  # if direct execution is not possible add this task to the queue
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
    Exec.queueCounter.host[host]++
    Exec.queueCounter.priority[@setup.priority]++

  # ### Result

  # run defined checks on result
  checkResult: (cb) ->
    # find check to use
    list = @setup.check ? {
      noExitCode:
        retry: @setup.retry?.times
    }
    # run checks
    for n, v of list
      return cb new Error "Unknown check function #{n} in Exec" unless check[n]?
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
            control: @control
          # run again
          this.run cb
        , @setup.retry.interval ? @conf.retry.error.interval
      return cb err, this
    # everything ok, go on
    debug "#{@name} succeeded"
    cb null, this

  stdout: (data) ->
    data ?= @result
    data.stdout ?= data.lines
    .filter (e) -> e[0] is 1
    .map (e) -> e[1]
    .join '\n'

  stderr: (data) ->
    data ?= @result
    data.stderr ?= data.lines
    .filter (e) -> e[0] is 2
    .map (e) -> e[1]
    .join '\n'

module.exports = Exec
