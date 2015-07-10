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
carrier = require 'carrier'
# include alinex modules

run = (cb) ->
  # store process information
  @process =
    host: 'localhost'
    start: new Date()
  # start process
  setup = @setup
  try
    @proc = spawn setup.cmd, setup.args ? [],
      env: setup.env
      cwd: setup.cwd
      uid: setup.uid
      gid: setup.gid
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
  cmdline = ''
  for n, e of setup.env
    cmdline += " #{n}=#{e}"
  cmdline += " #{setup.cmd}"
  if setup.args?
    for a in setup.args
      if typeof a is 'string'
        cmdline += " #{a.replace /[ ]/, '\ '}"
      else
        cmdline += " #{a}"
  debugCmd chalk.yellow "#{@name} #{cmdline.trim()}"
  # collect output
  @result = []
  carrier.carry @proc.stdout, (line) =>
    @result.push [1, line]
    @emit 'stdout', line # send through
    debugOut "#{@name} #{line}"
  , 'utf-8', /\r?\n|\r(?!\n)/ # match also single \r
  carrier.carry @proc.stderr, (line) =>
    @result.push [2, line]
    @emit 'stderr', line # send through
    debugErr "#{@name} #{line}"
  , 'utf-8', /\r?\n|\r(?!\n)/ # match also single \r
  # error management
  @proc.on 'error', (err) =>
    @process.error = err

#      @retry cb
  # process finished
  @proc.on 'close', (@code, signal) =>
    @process.end = new Date()
    if @code
      debugCmd "#{@name} exit: code #{@code} after #{@process.end-@process.start} ms"
    else unless @code?
      debugCmd "#{@name} exit: signal #{signal} after #{@process.end-@process.start} ms"
      @code = -1
    @emit 'done', @code
#      @error = @config.check @
#      return @retry cb if @error
    cb @process.error, this if cb

module.exports =
  run: run
