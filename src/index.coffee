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
# include alinex modules
config = require 'alinex-config'
# internal helpers
schema = require './configSchema'
spawn = require './spawn'

# Class definition
# -------------------------------------------------
class Exec

  @init: (cb) ->
    # set module search path
    config.register false, fspath.dirname __dirname
    # add schema for module's configuration
    config.setSchema '/exec', schema, cb

  @run: (setup, cb) ->
    proc = new Exec setup
    proc.run cb

  constructor: (@setup) ->

  run: (cb) -> config.init (err) ->
    return cb err if err
    # check for local or remote
    if @setup.remote
      throw new Error "Remote execution using ssh not implemented, yet."
    # run locally
    debug "run locally"
    spawn.run this, cb

module.exports = Exec
