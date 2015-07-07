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


# Class definition
# -------------------------------------------------
class Exec

  @init: (cb) ->
    # set module search path
    config.register false, fspath.dirname __dirname
    # add schema for module's configuration
    config.setSchema '/exec', schema, cb





module.exports = Exec
