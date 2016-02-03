# Result checks
# =================================================

# Node Modules
# -------------------------------------------------

# include base modules


abstract = (text) ->
  lines = text.split(/\n/)
  lines = lines[0..5].concat 'and more...' if lines.length > 6
  lines.join '\n'

module.exports =

  nothing: -> return false

  noExitCode: ->
    return false if @result.code is 0
    new Error "Process #{@setup.cmd} returned exit code #{@result.code} but should be 0."

  exitCode: (args...) ->
    return false if @result.code in args
    new Error """
    Process #{@setup.cmd} returned not allowed exit code #{@result.code}.
    Only #{args.join ', '} #{if args.length is 1 then 'is' else 'are'} allowed as exit code.
    """

  noStderr: ->
    return false unless res = @stderr()
    new Error """
    STDERR of #{@setup.cmd} should be empty but got:
    #{abstract res}
    """

  noStdout: ->
    return false unless res = @stdout()
    new Error """
    STDOUT of #{@setup.cmd} should be empty but got:
    #{abstract res}
    """

  stderr: ->
    return false if @stderr()
    new Error "STDERR of #{@setup.cmd} should be set but was empty"

  stdout: ->
    return false if @stdout()
    new Error "STDOUT of #{@setup.cmd} should be set but was empty"

  matchStdout: (ok, report) ->
    return false if @stdout().match ok
    if report?
      res = @stdout().match report
      if res?.input
        res = if res.length > 1 then res[1..-1] else [res[0]]
    reason = if res?
      "with: \"#{res.join '", "'}\""
    else
      "because got:\n#{abstract @stdout()}"
    new Error "STDOUT of #{@setup.cmd} should match #{ok} but failed #{reason}."

  matchStderr: (ok, report) ->
    return false if @stderr().match ok
    if report?
      res = @stderr().match report
      if res?.input
        res = if res.length > 1 then res[1..-1] else [res[0]]
    reason = if res?
      "with: \"#{res.join '", "'}\""
    else
      "because got:\n#{abstract @stderr()}"
    new Error "STDERR of #{@setup.cmd} should match #{ok} but failed #{reason}."

  notMatchStderr: (fail) ->
    return false unless res = @stderr().match fail
    if res.input
      res = if res.length > 1 then res[1..-1] else [res[0]]
    new Error "Process #{@setup.cmd} failed with: \"#{res.join '\", \"'}\""

  stdoutLines: (min, max) ->
    lines = if @stdout() then @stdout().split /\n/ else []
    min ?= lines.length
    max ?= lines.length
    return false if min <= lines.length <= max
    new Error "Process #{@setup.cmd} should have #{min}..#{max} number of lines
    but has #{lines.length}"
