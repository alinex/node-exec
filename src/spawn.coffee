# Local execution using spawn
# =================================================
# This is an object oriented implementation around the core `process.spawn`
# command and alternatively ssh connections.

# Node Modules
# -------------------------------------------------

# include base modules
debug = require('debug')('exec:spawn')
chalk = require 'chalk'
fspath = require 'path'
# include alinex modules

module.exports =
  run: (exec, cb) ->
    debug "run locally"
    cb()
