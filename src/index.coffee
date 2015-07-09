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

objectId = 0

# Class definition
# -------------------------------------------------
class Exec extends EventEmitter

  @init: async.once this, (cb) ->
    debug "initialize"
    # set module search path
    config.register false, fspath.dirname __dirname
    # add schema for module's configuration
    config.setSchema '/exec', schema, cb

  @run: (setup, cb) ->
    proc = new Exec setup
    proc.run cb

  constructor: (@setup) ->
    @id = ++objectId
    host = 'localhost'
    @name = chalk.grey "#{host}##{@id}:"
    debug "#{@name} created new instance"

  run: (cb) -> config.init (err) =>
    return cb err if err
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
      debug "#{@name} succeeded"
      cb null, this


  stdout: ->
    @result.filter (e) -> e[0] is 1
    .map (e) -> e[1]
    .join '\n'

  stderr: ->
    @result.filter (e) -> e[0] is 2
    .map (e) -> e[1]
    .join '\n'


module.exports = Exec