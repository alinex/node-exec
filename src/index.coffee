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

  @init: async.once this, (cb) ->
    debug "initialize"
    # set module search path
    config.register false, fspath.dirname __dirname
    # add schema for module's configuration
    config.setSchema '/exec', schema, (err) ->
      return cb err if err
      config.init cb

  @run: (setup, cb) ->
    Exec.init (err) ->
      return cb err if err
      proc = new Exec setup
      proc.run cb

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

  run: (cb) ->
    @conf = config.get '/exec'
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
      @check cb

  check: (cb) ->
    # find check to use
    list = @setup.check ? {
      noExitCode:
        retry: @setup.retry?.times
    }
    # run checks
    for n, v of list
      return cb new Error "Unknown check function #{n} in Exec" unless check.result[n]?
      err = check.result[n].apply this, v.args ? null
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
