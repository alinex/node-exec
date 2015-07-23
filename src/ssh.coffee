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
  pool[host] ?= {}

  open host, (err, conn) ->
    console.log 'TEST DONE'
#    console.log util.inspect conn, {depth: null}


#  console.log util.inspect pool, {depth: null}
#  return cb()


module.exports =
  run: run
  vital: vital

open = (host, cb) ->
  conf = config.get 'exec/remote/server/' + host
  # make connection
  conn = new ssh.Client()
  conn.name = chalk.grey "ssh://#{conf.username}@#{conf.host}:#{conf.port}"
  debug "#{conn.name} create new connection"
  conn.on 'ready', ->
    debug "#{conn.name} connection established"
    cb null, conn
  .on 'banner', (msg, lang) ->
    debug chalk.grey "#{conn.name} #{msg.replace '\n', '\n'+conn.name}"
  .on 'error', (err) ->
    debug chalk.magenta "#{conn.name} got error: #{err.message}"
  .on 'end', ->
    debug chalk.grey "#{conn.name} was closed"
  .connect
    host: conf.host
    port: conf.port
    username: conf.username
#    password: conf.password
    privateKey: require('fs').readFileSync conf.privateKey
