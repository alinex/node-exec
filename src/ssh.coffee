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

# Connection pool
# -------------------------------------------------
pool = {}

# Run local command
# -------------------------------------------------
run = (cb) ->
  host = @setup.remote
  conf = config.get 'exec/remote/server/' + host
  # set command
  cmdline = [@setup.cmd]
  if @setup.args
    cmdline = cmdline.concat @setup.args.map (e) -> "'#{e.toString().replace '\'', '\\\''}'"
  # support priority based nice values
  prio = @conf.priority.level[@setup.priority]
  if prio.nice
    if prio.nice > 0 or conf.username is 'root'
      # add support for nice call
      cmdline.unshift 'nice', '-n', prio.nice
  # set working directory
  if @setup.dir
    cmdline.unshift 'cd', "'#{@setup.dir.replace '\'', '\\\''}'", '&&'
  # set environment to english language
  env = @setup.env ? {LANG: 'C', LC_ALL: 'C'}
  cmdline.unshift "#{k}=#{v}" for k, v of env


  console.log cmdline



  return cb()

# Check vital signs
# -------------------------------------------------
vital = async.onceTime (host, vital, date, cb) ->
  return cb() if vital.date is date
  ######################################### support groups
  # reinit
  vital.date = date
  vital.error = {}
  vital.startload = 0
  # connect to host and get data
  connect host, (err, conn) ->
    debug chalk.grey "#{conn.name} detect vital signs"

    async.parallel [
      (cb) -> startmax conn, vital, host, cb
      (cb) -> top conn, vital, cb
    ], (err) ->
      return cb err if err
      debug chalk.grey "#{conn.name} vital signs: #{util.inspect(vital).replace /\s+/g, ' '}"
      cb null, vital

# ### get the starmax value
# THis is based on the number of cpus and the configuration value
startmax = (conn, vital, host, cb) ->
  return cb() if vital.startmax?
  conf = config.get 'exec'
  exec conn, "cat /proc/cpuinfo | awk '/^processor/{print $3}' | tail -1", (err, cpus) ->
    return cb err if err
    vital.startmax = (conf.remote.server[host].startload ? conf.retry.vital.startload) *
    conf.retry.vital.interval / 1000 * cpus
    cb()

# ### get load, cpu usage and free mem
# This is taken from the top output.
top = (conn, vital, cb) ->
  exec conn, 'LANG=C top -bn3 | head -n5', (err, stdout) ->
    return cb err if err
    lines = stdout.split /\n/
    vital.load = lines[0].match(/load average: ([0-9.]+), ([0-9.]+), ([0-9.]+)/)[1..3]
    .map parseFloat
    vital.cpu = 1 - parseFloat(lines[2].match(/([0-9.]+) id/)[1]) / 100
    mem = lines[3].match /(\d+)\D*\d+\D*(\d+)/
    vital.freemem = parseInt(mem[2]) / parseInt(mem[1])
    cb()

# ### Short execution of helper calls
exec = (conn, cmdline, cb) ->
  stdout = ''
  conn.exec cmdline, (err, stream) ->
    return cb err if err
    stream.on 'close', (code, signal) ->
      if code or signal
        return cb new Error "Got return code #{code} (signal #{signal}) from: #{cmdline}"
      return cb null, stdout.trim()
    .on 'data', (data) -> stdout += data
    .stderr.on 'data', (data) -> debug "#{conn.name} Command #{cmdline} got error:
      #{data}"


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
  return cb null, pool[host] if pool[host]
  unless host in Object.keys conf.server
    return cb new Error "The remote server '#{host}' is not configured."
  open host, (err, conn) ->
    return cb err if err
    pool[host] = conn
    cb null, conn

# ### Open a new connection
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

# ### Close the connection
close = (host, conn) ->
  delete pool[host]
  conn.end()
