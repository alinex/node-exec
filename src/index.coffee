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
EventEmitter = require('events').EventEmitter
# include alinex modules
config = require 'alinex-config'
async = require 'alinex-async'
# internal helpers
schema = require './configSchema'
spawn = require './spawn'
check = require './check'

objectId = 0

# Class definition
# -------------------------------------------------
class Exec extends EventEmitter

  @queue: {}

  @queueCounter:
    total: 0
    host: {}
    priority: {}

  @init: async.once this, (cb) ->
    debug "initialize"
    # set module search path
    config.register false, fspath.dirname __dirname
    # add schema for module's configuration
    config.setSchema '/exec', schema, (err) ->
      return cb err if err
      config.init cb


  @worker: ->
    console.log 'WORKER'
    async.each Object.keys(@queue), (host, cb) ->
      console.log 'HOST', host
      prios = Object.keys @queue[host]
      prios.reverse()
      asyn.eachSeries prios, (prio, cb) ->
        console.log 'PRIO', prio
        list = @queue[host][prio]
        async.whilst ->
          list.length
        , (cb) ->
          # check
          @vitalCheck host, prio, (err) ->
            # stop if check failed
            return cb err if err
            console.log 'working...'
            # get first entry
            [exec, ocb] = list.shift()
            # reduce counter
            @queueCounter.total--
            @queueCounter.host[host]--
            @queueCounter.priority[prio]--
            # exec run
            exec.run ocb
            cb()
        , (err) ->
          delete @queue[host][prio] unless list.length
          cb()
      , (err) ->
        delete @queue[host] unless @queue[host].length
        cb()
    , ->
      # stop worker if completely done
      return unless Exec.queueCounter.total
      # if not rerun it later
      setTimeout @worker, config.get 'exec/retry/queue/interval'

  @vitalCheck: (host, priority, cb) ->
    conf = config.get '/exec'
    vital = @vital[host] ?= {}
    # get vital data
    date = Math.floor new Date().getTime() / conf.retry.vital.interval
    spawn.vital vital, date, (err) ->
      return cb err if err
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

  @run: (setup, cb) ->
    Exec.init (err) ->
      return cb err if err
      proc = new Exec setup
      proc.run cb

  constructor: (@setup) ->
    @id = ++objectId
    Exec.vital ?= {}
    host = 'localhost'
    @name = chalk.grey "#{host}##{@id}:"
    # set priority
    prio = config.get 'exec/priority'
    @setup.priority ?= prio.default
    unless prio.level[@setup.priority]
      debug chalk.red "Undefined priority #{@setup.priority} - using default"
      @setup.priority = prio.default
    debug "#{@name} created new instance with #{@setup.priority} priority"

  run: (cb) ->
    host = @setup.remote ? 'localhost'
    # if queue for host exists add this
    return @addQueue cb if Exec.queueCounter.host[host]
    # check existing vital data
    @conf ?= config.get '/exec'
    Exec.vitalCheck host, @setup.priority, (err) =>
      return @addQueue cb if err
      # check for local or remote
      if @setup.remote
        throw new Error "Remote execution using ssh not implemented, yet."
      # run locally
      debug "#{@name} run locally"
      spawn.run.call this, (err) =>
        if err
          debug "#{@name} failed with #{err}"
          return cb err
        # success
        @checkResult cb

  addQueue: (cb) ->
    host = @setup.remote ? 'localhost'
    if err = Exec.vital[host].error[@setup.priority]
      debug chalk.grey "#{@name} add to queue because of: #{err.message}"
    else
      debug chalk.grey "#{@name} add to queue because other processes are waiting"
    unless Exec.queueCounter.total
      setTimeout Exec.worker, config.get 'exec/retry/queue/interval'
    Exec.queue[host] ?= {}
    Exec.queue[host][@setup.priority] = [this, cb]
    Exec.queueCounter.total++
    Exec.queueCounter.host[host]++
    Exec.queueCounter.priority[@setup.priority]++

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
