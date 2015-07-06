# Execution class
# =================================================
# This is an object oriented implementation around the core `process.spawn`
# command and alternatively ssh connections.

# Node Modules
# -------------------------------------------------

# include base modules
debug = require('debug')('exec')
chalk = require 'chalk'
# include alinex modules
config = require 'alinex-config'
# internal helpers
schema = require './configSchema'


# Class definition
# -------------------------------------------------
class Exec

  @init: ->
    config.setSchema '/exec', schema, (err) -> throw err if err





module.exports = Exec