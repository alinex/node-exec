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
#####  vital.startmax ?= conf.startload * conf.interval / 1000 * os.cpus().length
  debug chalk.grey "detect vital signs"

  connect host, (err, conn) ->
#    alex@samsung-R505 ~/a3/node-exec $ LANG=C top -bn1 | head
#top - 21:29:35 up 14 days, 41 min,  4 users,  load average: 1.25, 1.88, 1.17
#Tasks: 166 total,   1 running, 165 sleeping,   0 stopped,   0 zombie
#%Cpu(s): 28.0 us,  9.7 sy,  0.7 ni, 59.4 id,  1.9 wa,  0.0 hi,  0.2 si,  0.0 st
#KiB Mem:   1803540 total,  1539048 used,   264492 free,    42960 buffers
#KiB Swap:  1831932 total,   376484 used,  1455448 free.   507328 cached Mem
    conn.exec 'top -bn3 | head -n5',
      env:
        LANG: 'C'
    , (err, stream) ->
      return cb err if err
      stream.on 'close', (code, signal) ->
        console.log('Stream :: close :: code: ' + code + ', signal: ' + signal)
      .on 'data', (data) ->
        console.log('STDOUT: ' + data)
      .stderr.on 'data', (data) ->
        console.log('STDERR: ' + data)
    conn.exec 'uptime',
      env:
        LANG: 'C'
    , (err, stream) ->
      return cb err if err
      stream.on 'close', (code, signal) ->
        console.log('Stream :: close :: code: ' + code + ', signal: ' + signal)
      .on 'data', (data) ->
        console.log('STDOUT: ' + data)
      .stderr.on 'data', (data) ->
        console.log('STDERR: ' + data)


  #    start = cpuMeasure()
  #    setTimeout ->
  #      end = cpuMeasure()
  #      vital.cpu = 1 - (end[1] - start[1]) / (end[0] - start[0])
  #      debug chalk.grey "vital signs: #{util.inspect(vital).replace /\s+/g, ' '}"
  #      cb()
  #    , MEASURE_TIME
      vital.date = date
      vital.error = {}
      vital.startload = 0
  #    # freemem
  #    free -b
  #    vital.freemem = os.freemem() / os.totalmem()
  #    uptime
  #    vital.load = os.loadavg().map (v) -> v / os.cpus().length

      console.log vital

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
  conf = config.get 'exec/remote'
  #  support groups
  if host in Object.keys conf.group
    return cb new Error "Groups not implemented, yet."
    ################################################################################
  return cb null, pool[host] if pool[host]
  unless host in Object.keys conf.server
    return cb new Error "The remote server '#{host}' is not configured."
  open host, (err, conn) ->
    return cb err if err
    pool[host] = conn
    cb null, conn

open = (host, cb) ->
  conf = config.get 'exec/remote/server/' + host
  # make new connection
  conn = new ssh.Client()
  conn.name = chalk.grey "ssh://#{conf.username}@#{conf.host}:#{conf.port}"
  debug "#{conn.name} open ssh connection"
  conn.on 'ready', ->
    debug chalk.grey "#{conn.name} connection established"
    cb null, conn
  .on 'error', (err) ->
    debug chalk.magenta "#{conn.name} got error: #{err.message}"
  .on 'end', ->
    debug chalk.grey "#{conn.name} connection closed"
  .connect object.extend {}, conf,
    debug: unless conf.debug then null else (msg) ->
      debug chalk.grey "#{conn.name} #{msg}"

close = (host, conn) ->
  delete pool[host]
  conn.end()
