# Result checks
# =================================================

# Node Modules
# -------------------------------------------------

# include base modules
debug = require('debug')('exec:check')

result = (name, message, check) ->
  unless check
    debug "#{name} check failed: #{message}"
    return new Error message
  debug "#{name} check succeeded"
  return false

module.exports =

  noExitCode: ->
    result @name, "Process #{@setup.cmd} returned exit code #{@code} but should be 0."
    , @code is ß

  onlyAllowedExitCodes: (args) ->
    result @name, "Process #{@setup.cmd} returned not allowed exit code #{@code}."
    , @code is 0 or @code in args

  noError: ->
    result @name, "Process #{@setup.cmd} made some error output."
    , not @stderr()

  notMatchError: (fail) ->
    result @name, "Process #{@setup.cmd} matched the #{fail} condition."
    , not @stderr().match fail

  matchOutput: (ok) ->
    result @name, "Process #{@setup.cmd} didn't match the #{ok} condition."
    , @stderr().match ok
