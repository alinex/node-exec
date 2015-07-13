# Result checks
# =================================================

# Node Modules
# -------------------------------------------------

# include base modules
debug = require('debug')('exec:check')

result = (name, message, check) ->
  return false if check
  debug "#{name} check failed: #{message}"
  return new Error message

module.exports =

  result:
    noExitCode: ->
      result @name, "Process #{@setup.cmd} returned exit code #{@result.code} but should be 0."
      , @result.code is 0

    onlyAllowedExitCodes: (args) ->
      result @name, "Process #{@setup.cmd} returned not allowed exit code #{@result.code}."
      , @result.code is 0 or @result.code in args

    noError: ->
      result @name, "Process #{@setup.cmd} made some error output."
      , not @stderr()

    notMatchError: (fail) ->
      result @name, "Process #{@setup.cmd} matched the #{fail} condition."
      , not @stderr().match fail

    matchOutput: (ok) ->
      result @name, "Process #{@setup.cmd} didn't match the #{ok} condition."
      , @stderr().match ok
