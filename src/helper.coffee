# Helper class
# =================================================

# Node Modules
# -------------------------------------------------

# include base modules
# include alinex modules
config = require 'alinex-config'

# Get cmdline out of command setup
# -------------------------------------------------
module.exports.cmdline = (setup, host) ->
  conf = config.get 'exec'
  cmdline = [setup.cmd]
  if setup.args
    cmdline = cmdline.concat setup.args.map escape
  # support changes user/group
  if setup.uid? or setup.gid?
    cmdline.unshift '-u', "\\##{setup.uid}" if setup.uid?
    cmdline.unshift '-g', "\\##{setup.gid}" if setup.gid?
    cmdline.unshift 'sudo'
  if setup.timeout
    cmdline.unshift 'timeout', setup.timeout / 1000
  # support priority based nice values
  prio = conf.priority.level[setup.priority]
  if prio.nice
    if prio.nice > 0 or conf.remote?.server?[host]?.username is 'root' or
    setup.uid is 0 or (not setup.uid? and not process.getuid())
      # add support for nice call
      cmdline.unshift 'nice', '-n', prio.nice
  # set timeout
  if setup.timeout
    cmdline.unshift 'timeout', setup.timeout/1000
  # set working directory
  if setup.cwd
    cmdline.unshift 'cd', escape(setup.cwd), '&&'
  # set environment to english language
  env = setup.env ? {LANG: 'C', LC_ALL: 'C'}
  for k, v of env
    continue unless v?
    cmdline.unshift "#{k}=#{if v.match /\s/ then '"' + v + '"' else v}"
  cmdline.join(' ').trim()

escape = (arg) ->
  if /[^A-Za-z0-9_\/:=-]/.test arg
    arg = "'#{arg.replace /'/g, "'\\''"}'"
    # unduplicate single-quote at the beginning
    .replace /^(?:'')+/g, ''
    # remove non-escaped single-quote if there are enclosed between 2 escaped
    .replace /\\'''/g, "\\'"
  arg
