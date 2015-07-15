# Result checks
# =================================================

# Node Modules
# -------------------------------------------------

# include base modules

module.exports =

  result:
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
      res = res.split /\n/
      res = res[0..5].concat 'and more...' if res.length > 6
      new Error """
      STDERR of #{@setup.cmd} should be empty but got:
      #{res.join '\n'}
      """

    noStdout: ->
      return false unless res = @stdout()
      res = res.split /\n/
      res = res[0..5].concat 'and more...' if res.length > 6
      new Error """
      STDOUT of #{@setup.cmd} should be empty but got:
      #{res.join '\n'}
      """

    matchStdout: (ok, report) ->
      return false if @stdout().match ok
      if report?
        res = @stdout().match report
        if res?.input
          res = if res.length > 1 then res[1..-1] else [res[0]]
      msg = "STDOUT of #{@setup.cmd} should match #{ok} but failed"
      msg += if res? then " with: \"#{res.join '", "'}\"" else '.'
      new Error msg

    matchStderr: (ok, report) ->
      return false if @stderr().match ok
      if report?
        res = @stderr().match report
        if res?.input
          res = if res.length > 1 then res[1..-1] else [res[0]]
      msg = "STDERR of #{@setup.cmd} should match #{ok} but failed"
      msg += if res? then " with: \"#{res.join '", "'}\"" else '.'
      new Error msg

    notMatchStderr: (fail) ->
      return false unless res = @stderr().match fail
      msg =
      if res.input
        res = if res.length > 1 then res[1..-1] else [res[0]]
      new Error "Process #{@setup.cmd} failed with: \"#{res.join '\", \"'}\""
