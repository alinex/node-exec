# Result checks
# =================================================

# Node Modules
# -------------------------------------------------

# include base modules
debug = require('debug')('exec:check')

failure = (name, message) ->
  debug "#{name} check failed: #{message}"
  return new Error message

module.exports =

  result:
    noExitCode: ->
      return false unless @result.code is 0
      failure @name, "Process #{@setup.cmd} returned exit code #{@result.code} but should be 0."

    onlyAllowedExitCodes: (args) ->
      return false unless @result.code is 0 or @result.code in args
      failure @name, "Process #{@setup.cmd} returned not allowed exit code #{@result.code}."

    noError: ->
      return false unless res = @stderr()
      res = res.split /\n/
      res = res[0..5].concat 'and more...' if res.length > 6
      failure  @name, "Process #{@setup.cmd} should not output on stderr but got:\n
      #{res.join '\n'}"

    notMatchError: (fail) ->
      return false unless res = @stderr().match fail
      msg = "Process #{@setup.cmd} failed with:\n"
      if res.input
        res = if res.length > 1 then res[1..-1] else [res[0]]
      msg += res.join '\n'
      failure @name, msg

    matchOutput: (ok) ->
      return false if res = @stdout().match ok
      failure @name, "Process #{@setup.cmd} should output #{ok} but failed."
