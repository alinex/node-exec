# Local execution using spawn
# =================================================
# This is an object oriented implementation around the core `process.spawn`
# command and alternatively ssh connections.

# Node Modules
# -------------------------------------------------

# include base modules
debug = require('debug')('exec:spawn')
debugCmd = require('debug')('exec:cmd')
debugOut = require('debug')('exec:out')
debugErr = require('debug')('exec:err')
chalk = require 'chalk'
{spawn} = require 'child_process'
util = require 'util'
os = require 'os'
carrier = require 'carrier'
# include alinex modules
{object} = require 'alinex-util'
async = require 'alinex-async'
# include helper classes
helper = require './helper'

# Configuration
# -------------------------------------------------
MEASURE_TIME = 1000

# Run local command
# -------------------------------------------------
run = (cb) ->
  # set command
  cmd = @setup.cmd
  args = if @setup.args then @setup.args[0..] else []
  # support priority based nice values
  prio = @conf.priority.level[@setup.priority]
  if prio.nice and process.platform is 'linux'
    if prio.nice > 0 or (@setup.uid is 0 or (not @setup.uid? and not process.getuid()))
      # add support for nice call
      args.unshift '-n', prio.nice, cmd # nice setting, command
      cmd = 'nice'
  # set environment to english language
  env = @setup.env ? object.extend process.env,
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
      uid: @setup.uid
      gid: @setup.gid
  catch err
    if err.message is 'spawn EMFILE'
      interval = @conf.retry.ulimit.interval
      debug chalk.grey "#{@name} too much processes are opened, waiting
      #{interval} ms..."
      @emit 'wait', interval
      return setTimeout (=> run.call this, cb), interval
    throw err
  # output debug lines
  debug "#{@name} start using spawn under pid #{@proc.pid}"
  @process.pid = @proc.pid
  debugCmd chalk.yellow "#{@name} #{helper.cmdline @setup}"
  # collect output
  @result = {}
  @result.lines = []
  carrier.carry @proc.stdout, (line) =>
    @result.lines.push [1, line]
    @emit 'stdout', line # send through
    debugOut "#{@name} #{line}"
  , 'utf-8', /\r?\n|\r(?!\n)/ # match also single \r
  carrier.carry @proc.stderr, (line) =>
    @result.lines.push [2, line]
    @emit 'stderr', line # send through
    debugErr "#{@name} #{line}"
  , 'utf-8', /\r?\n|\r(?!\n)/ # match also single \r
  # error management
  @proc.on 'error', (err) =>
    @process.error = err
  # process finished
  @proc.on 'close', (code, signal) =>
    @result.code = code
    @process.end = new Date()
    if signal?
      debugCmd "#{@name} exit: signal #{signal} after #{@process.end-@process.start} ms"
      @code ?= -1
    else
      debugCmd "#{@name} exit: code #{@result.code} after #{@process.end-@process.start} ms"
    @emit 'done', @result.code
    cb @process.error, this if cb

# Check vital signs
# -------------------------------------------------
vital = async.onceTime (host, vital, date, cb) ->
  return cb() if vital.date is date
  # init startmax
  conf = config.get 'exec/retry/vital'
  vital.startmax ?= conf.startload * conf.interval / 1000 * os.cpus().length
  # calculate cpu usage
  start = cpuMeasure()
  setTimeout ->
    end = cpuMeasure()
    vital.cpu = 1 - (end[1] - start[1]) / (end[0] - start[0])
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

# ### Measure CPU usage
cpuMeasure = ->
  cpus = os.cpus()
  total = 0
  idle = 0
  for core in cpus
    total += v for k, v of core.times
    idle += core.times.idle
  [total, idle]

# Export public methods
# -------------------------------------------------
module.exports =
  run: run
  vital: vital
