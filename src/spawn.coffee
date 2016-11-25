# Local execution using spawn
# =================================================
# This is an object oriented implementation around the core `process.spawn`
# command and alternatively ssh connections.


# Node Modules
# -------------------------------------------------
debug = require('debug')('exec:spawn')
debugCmd = require('debug')('exec:cmd')
debugOut = require('debug')('exec:out')
debugErr = require('debug')('exec:err')
chalk = require 'chalk'
{spawn} = require 'child_process'
os = require 'os'
carrier = require 'carrier'
# include alinex modules
util = require 'alinex-util'
config = require 'alinex-config'
# include helper classes
helper = require './helper'


# Configuration
# -------------------------------------------------

# @type {Integer} milliseconds to measure vital signs
MEASURE_TIME = 1000


# Exported methods
# -------------------------------------------------

# @param {Function(Error, Exec)} cb callback to be caalled after done with `Error`
# or the `Exec` object itself
module.exports.run = run = (cb) ->
  @host = 'local'
  # set command
  cmd = @setup.cmd
  args = if @setup.args then @setup.args[0..] else []
  # support priority based nice values
  conf = config.get '/exec'
  prio = conf.priority.level[@setup.priority]
  if prio.nice and process.platform is 'linux'
    if prio.nice > 0 or (@setup.uid is 0 or (not @setup.uid? and not process.getuid()))
      # add support for nice call
      args.unshift '-n', prio.nice, cmd # nice setting, command
      cmd = 'nice'
  # set environment to english language
  env = @setup.env ? util.extend 'MODE CLONE', process.env,
    LANG: 'C'
    LC_ALL: 'C'
  # store process information
  @process =
    host: 'localhost'
    start: new Date()
  # start process
  try
    @proc = spawn cmd, args,
      env: env
      cwd: @setup.cwd
      timeout: @setup.timeout
      killSignal: 'SIGKILL'
  catch error
    if error.message is 'spawn EMFILE'
      interval = conf.retry.ulimit.interval
      if debug.enabled
        debug chalk.grey "#{@name} too much processes are opened, waiting
        #{interval} ms..."
      @emit 'wait', interval
      return setTimeout (=> run.call this, cb), interval
    throw error
  # output debug lines
  debug "#{@name} start using spawn under pid #{@proc.pid}" if debug.enabled
  @process.pid = @proc.pid
  debugCmd chalk.yellow "#{@name} #{helper.cmdline @setup}" if debugCmd.enabled
  # collect output
  @result = {}
  @result.lines = []
  carrier.carry @proc.stdout, (line) =>
    @result.lines.push [1, line]
    @emit 'stdout', line if line # send through
    debugOut "#{@name} #{line}" if debugOut.enabled
  , 'utf-8', /\r?\n|\r(?!\n)/ # match also single \r
  carrier.carry @proc.stderr, (line) =>
    @result.lines.push [2, line]
    @emit 'stderr', line if line # send through
    debugErr "#{@name} #{line}" if debugErr.enabled
  , 'utf-8', /\r?\n|\r(?!\n)/ # match also single \r
  # error management
  @proc.on 'error', (err) =>
    @process.error = err
  # process finished
  @proc.on 'close', (code, signal) =>
    clearTimeout @timer if @prockill?
    code = 127 if code is -2 # fix code for not found command
    @result.code = code
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
  if @setup.timeout
    @timer = setTimeout =>
      debugCmd chalk.grey "#{@name} send KILL because timeout exceeded" if debugCmd.enabled
      @proc.kill()
    , @setup.timeout + 1000

# Check vital signs
#
# @param {String} host
# @param {Object} vital
# @param {Date} date
# @param {Function(Error, Exec)} cb callback to be caalled after done with `Error`
# or the `Exec` object itself
module.exports.vital = (vital, date, cb) ->
  @host = 'local'
  vital[@host] ?= {}
  vital = vital[@host]
  return cb() if vital.date is date
  # init startmax
  conf = config.get 'exec/retry/vital'
  vital.startmax ?= conf.startload * conf.interval / 1000 * os.cpus().length
  # calculate cpu usage
  start = cpuMeasure()
  setTimeout ->
    end = cpuMeasure()
    vital.cpu = 1 - (end[1] - start[1]) / (end[0] - start[0])
    if debug.enabled
      debug chalk.grey "vital signs: #{util.inspect(vital).replace /\s+/g, ' '}"
    cb()
  , MEASURE_TIME
  # set the other values
  vital.date = date
  vital.error = {}
  vital.startload = 0
  # freemem
  vital.freemem = os.freemem() / os.totalmem()
  vital.load = os.loadavg().map (v) -> v / os.cpus().length


# Helper Methods
# ------------------------------------------------------------

# Measure CPU usage
#
# @return {[<Integer>, <Integer>]} total time and idle time in milliseconds
cpuMeasure = ->
  cpus = os.cpus()
  total = 0
  idle = 0
  for core in cpus
    total += v for k, v of core.times
    idle += core.times.idle
  [total, idle]
