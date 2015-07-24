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

# General setup
# -------------------------------------------------
pool = {}

# Run local command
# -------------------------------------------------
run = (cb) ->
  return cb()

# Check vital signs
# -------------------------------------------------
vital = async.onceTime (host, vital, date, cb) ->
  return cb() if vital.date is date
  conf = config.get 'exec/remote'
  #  support groups
  if host in Object.keys conf.group
    return cb new Error "Groups not implemented, yet."
    ################################################################################
  unless host in Object.keys conf.server
    return cb new Error "The remote server '#{host}' is not configured."
  debug chalk.grey "detect vital signs"

  connect host, (err, conn) ->
#    start = cpuMeasure()
#    setTimeout ->
#      end = cpuMeasure()
#      vital.cpu = 1 - (end[1] - start[1]) / (end[0] - start[0])
#      debug chalk.grey "vital signs: #{util.inspect(vital).replace /\s+/g, ' '}"
#      cb()
#    , MEASURE_TIME
    vital.date = date
#    vital.error = {}
#    vital.startload = 0
#    # freemem
#    vital.freemem = os.freemem() / os.totalmem()
#    vital.load = os.loadavg().map (v) -> v / os.cpus().length

    console.log vital

    disconnect host, conn
#    console.log util.inspect conn, {depth: null}


#  console.log util.inspect pool, {depth: null}
#  return cb()

# Export public methods
# -------------------------------------------------
module.exports =
  run: run
  vital: vital


# Helper Methods
# -------------------------------------------------

# ### Connect to remote server
connect = (host, cb) ->
  conf = config.get 'exec/remote/server/' + host
  name = chalk.grey "ssh://#{conf.username}@#{conf.host}:#{conf.port}"
  pool[host] ?=
    spare: []
    numActive: 0
  # retry if too much sessions
  debug chalk.grey "#{name} get connection
  (#{pool[host].numActive}/#{conf.maxConnections} sessions,
  #{pool[host].spare.length}/#{conf.minSpare}-#{conf.maxSpare} spare)"
  if pool[host].numActive >= conf.maxConnections
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
  open host, (err, conn) ->
    pool[host].numActive++
    cb err, conn
    # check if more spares should be opened
    if pool[host].spare.length < conf.minSpare
      num = conf.minSpare - pool[host].spare.length
      async.each [1..num], (n, cb) ->
        open host, (err, conn) ->
          pool[host].spare.push conn
          debug chalk.grey "#{conn.name} add connection as spare
          (#{pool[host].numActive}/#{conf.maxConnections} sessions,
          #{pool[host].spare.length}/#{conf.minSpare}-#{conf.maxSpare} spare)"
          cb()
      , ->

open = (host, cb) ->
  conf = config.get 'exec/remote/server/' + host
  # make new connection
  conn = new ssh.Client()
  conn.name = chalk.grey "ssh://#{conf.username}@#{conf.host}:#{conf.port}"
  debug "#{conn.name} create new connection"
  conn.on 'ready', ->
    debug chalk.grey "#{conn.name} connection established
    (#{pool[host].numActive}/#{conf.maxConnections} sessions,
    #{pool[host].spare.length}/#{conf.minSpare}-#{conf.maxSpare} spare)"
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

# ### Close connection
disconnect = (host, conn, cb = -> ) ->
  conf = config.get 'exec/remote/server/' + host
  # check if more spare sessions are allowed
  if pool[host].spare.length >= conf.maxSpare
    return close host, conn, cb
  # push connection back to pool
  pool[host].spare.push conn
  pool[host].numActive--
  debug chalk.grey "#{conn.name} connection gone back to pool
  (#{pool[host].numActive}/#{conf.maxConnections} sessions,
  #{pool[host].spare.length}/#{conf.minSpare}-#{conf.maxSpare} spare)"
  return cb()

close = (host, conn, cb) ->
  conf = config.get 'exec/remote/server/' + host
  conn.end()
  debug chalk.grey "#{conn.name} connection closed
  (#{pool[host].numActive}/#{conf.maxConnections} sessions,
  #{pool[host].spare.length}/#{conf.minSpare}-#{conf.maxSpare} spare)"
  cb()
