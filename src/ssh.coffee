# Remote execution using ssh
# =================================================

# Node Modules
# -------------------------------------------------

# include base modules
debug = require('debug')('exec:ssh')
debugCmd = require('debug')('exec:cmd')
debugOut = require('debug')('exec:out')
debugErr = require('debug')('exec:err')
chalk = require 'chalk'
util = require 'util'
carrier = require 'carrier'
ssh = require 'ssh2'
# include alinex modules
{object} = require 'alinex-util'
async = require 'alinex-async'
config = require 'alinex-config'

pool = {}

run = (cb) ->
  return cb()

vital = async.onceTime (host, vital, date, cb) ->
  conf = config.get 'exec/remote'
  #  support groups
  if host in Object.keys conf.group
    return cb new Error "Groups not implemented, yet."
    ################################################################################
  unless host in Object.keys conf.server
    return cb new Error "The remote server '#{host}' is not configured."
  debug chalk.grey "detect vital signs"

  connect host, (err, conn) ->
    console.log 'TEST DONE'
    close host, conn
#    console.log util.inspect conn, {depth: null}


#  console.log util.inspect pool, {depth: null}
#  return cb()


module.exports =
  run: run
  vital: vital

connect = (host, cb) ->
  conf = config.get 'exec/remote/server/' + host
  pool[host] ?=
    spare: []
    numActive: 0
  # retry if too much sessions
  if pool[host].numActive >= conf.maxSessions
    debug chalk.grey "no free session on #{host}, retrying"
    setTimeout ->
      connect host, cb
    , config.get 'exec/ulimit/interval'
    return
  # check for spare session
  if conn = pool[host].spare.shift()
    # check if connection is valid
    ############################################################################
    return cb null, conn
  # make new connection
  conn = new ssh.Client()
  conn.name = chalk.grey "ssh://#{conf.username}@#{conf.host}:#{conf.port}"
  debug "#{conn.name} create new connection"
  conn.on 'ready', ->
    pool[host].numActive++
    debug "#{conn.name} connection established"
    cb null, conn
  .on 'banner', (msg, lang) ->
    debug chalk.grey "#{conn.name} #{msg.replace '\n', '\n'+conn.name}"
  .on 'error', (err) ->
    debug chalk.magenta "#{conn.name} got error: #{err.message}"
  .on 'end', ->
    debug chalk.grey "#{conn.name} was closed"
  .connect object.extend {}, conf,
    debug: unless conf.debug then null else (msg) ->
      debug chalk.grey "#{conn.name} #{msg}"

close = (host, conn, cb = {}) ->
  conf = config.get 'exec/remote/server/' + host
  conn.end()
  pool[host].numActive--
  debug "#{conn.name} connection closed"
  cb()
