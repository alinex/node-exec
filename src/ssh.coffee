# Remote execution using ssh
# =================================================


# Node Modules
# -------------------------------------------------
debug = require('debug')('exec:ssh')
debugCmd = require('debug')('exec:cmd')
debugOut = require('debug')('exec:out')
debugErr = require('debug')('exec:err')
chalk = require 'chalk'
async = require 'async'
carrier = require 'carrier'
# include alinex modules
ssh = require 'alinex-ssh'
util = require 'alinex-util'
config = require 'alinex-config'
# include helper classes
helper = require './helper'


# Exported methods
# -------------------------------------------------

# @param {Function(Error, Exec)} cb callback to be caalled after done with `Error`
# or the `Exec` object itself
module.exports.run = run = (cb) ->
  conf = config.get '/exec'
  # set command
  ssh.connect @setup.remote, (err, conn) =>
    return cb err if err
    @host = conn.name
    # correct name (maybe different with alternatives)
    @name = "#{conn.name}##{@id}"
    conn.process[@name] = this
    # create command line as newliner
    cmdline = helper.cmdline @setup
    debugCmd chalk.yellow "#{@name} #{cmdline}" if debugCmd.enabled
    # store process information
    @process =
      host: @host
      start: new Date()
    # collect output
    @result = {}
    @result.lines = []
    # start processing
    conn.exec cmdline, (err, stream) =>
      # error management
      if err
        conn.close()
        @process.error = err
        if err.message.match /open failed/
          interval = conf.retry.ulimit.interval
          if debug.enabled
            debug chalk.grey "#{@name} ssh open failed, waiting
            #{interval} ms..."
          @emit 'wait', interval
          return setTimeout (=> run.call this, cb), interval
        return cb err
      if @setup.timeout
        @timer = setTimeout ->
          if debugCmd.enabled
            debugCmd chalk.grey "#{@name} close stream because timeout exceeded"
          stream.emit 'close', -1, 15
        , @setup.timeout + 1000
      carrier.carry stream, (line) =>
        @result.lines.push [1, line]
        @emit 'stdout', line if line # send through
        debugOut "#{@name} #{line}" if debugOut.enabled
      , 'utf-8', /\r?\n|\r(?!\n)/ # match also single \r
      carrier.carry stream.stderr, (line) =>
        @result.lines.push [2, line]
        @emit 'stderr', line if line # send through
        debugErr "#{@name} #{line}" if debugErr.enabled
      , 'utf-8', /\r?\n|\r(?!\n)/ # match also single \r
      # process finished
      stream.on 'close', (code, signal) =>
        debug chalk.grey "#{@name} command execution done" if debug.enabled
        delete conn.process[@name]
        conn.done()
        clearTimeout @timer
        @result.code = code
        process.nextTick =>
          @process.end = new Date()
          if signal?
            @process.error = new Error "#{@name} exit: signal #{signal}
            after #{@process.end-@process.start} ms"
            @code ?= -1
          else if code
            @process.error = new Error "#{@name} exit: code #{@result.code}
            after #{@process.end-@process.start} ms"
          if @process.error?
            debugCmd @process.error.message
          @emit 'done', @result.code
          cb null, this if cb

# Check vital signs
#
# @param {String} host
# @param {Object} vital
# @param {Date} date
# @param {Function(Error, Exec)} cb callback to be caalled after done with `Error`
# or the `Exec` object itself
#module.exports.vital = util.function.onceTime (host, vital, date, cb) ->
module.exports.vital = (vital, date, cb) ->
  # connect to host and get data
  ssh.connect
    server: @setup.remote
    retry: config.get '/exec/retry/connect'
  , (err, conn) =>
    return cb err if err
    @host = conn.name
    @name = "#{conn.name}##{@id}"
    vital[@host] ?= {}
    vital = vital[@host]
    return cb vital.failed if vital.date is date and vital.failed
    return cb() if vital.date is date
    # reinit
    vital.date = date
    vital.error = {}
    vital.startload = 0
    # correct name (maybe different with alternatives)
    @name = "#{conn.name}##{@id}"
    debug chalk.grey "#{@name} detect vital signs" if debug.enabled
    async.parallel [
      (cb) -> startmax conn, vital, @host, cb
      (cb) -> top conn, vital, cb
    ], (err) =>
      return cb err if err
      if debug.enabled
        debug chalk.grey "#{@name} vital signs #{util.inspect(vital).replace /\s+/g, ' '}"
      cb()


# Helper Methods
# ------------------------------------------------------------

# This is based on the number of cpus and the configuration value
#
# @param
startmax = (conn, vital, host, cb) ->
  return cb() if vital.startmax?
  conf = config.get '/exec'
  exec conn, "nproc", (err, cpus) ->
    return cb err if err
    vital.startmax = conf.retry.vital.startload * conf.retry.vital.interval / 1000 * cpus
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
    .stderr.on 'data', (data) ->
      if debug.enabled
        debug "#{@name} Command #{cmdline} got error: #{data}"
