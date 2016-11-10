###
Result checks
=================================================
This module contains different methods which all can be used for result checking
on an already done job. Each of them can be configured within the job to run.
###

module.exports =

  ###
  #3 nothing()
  Dummy function which is always ok.
  ###

  # @return {Boolean} false
  #
  nothing: -> return false

  ###
  #3 noExitCode()
  Check that the job didn't return an error code.
  ###

  #
  # @return {Error} explaining what the job returned
  noExitCode: ->
    return false if @result.code is 0
    err = new Error "Process #{@setup.cmd} returned exit code #{@result.code} but should be 0."
    # add last five lines of error output
    err.description = (
      @result.lines
      .filter (e) -> e[0] is 2
      .map (e) -> e[1]
    )[-5..].join '\n'
    err

  ###
  #3 exitCode(code...)
  __Parameter:__
  Multiple `Integer` codes which are allowed.
  ###

  #
  # @return {Error} explaining what the job returned
  exitCode: (args...) ->
    return false if @result.code in args
    new Error """
    Process #{@setup.cmd} returned not allowed exit code #{@result.code}.
    Only #{args.join ', '} #{if args.length is 1 then 'is' else 'are'} allowed as exit code.
    """

  ###
  #3 noStderr()
  Check that there is nothing output on STDOUT by the job.
  ###

  #
  # @return {Error} explaining what was output
  noStderr: ->
    return false unless res = @stderr()
    new Error """
    STDERR of #{@setup.cmd} should be empty but got:
    #{abstract res}
    """

  ###
  #3 noStdout()
  Check that there is nothing output on STDERR by the job.
  ###

  #
  # @return {Error} explaining what was output
  noStdout: ->
    return false unless res = @stdout()
    new Error """
    STDOUT of #{@setup.cmd} should be empty but got:
    #{abstract res}
    """

  ###
  #3 stderr()
  Check that there was an output on STDERR from the job
  ###

  #
  # @return {Error} explaining that nothing was output
  stderr: ->
    return false if @stderr()
    new Error "STDERR of #{@setup.cmd} should be set but was empty"

  ###
  #3 stdout()
  Check that there was an output on STDOUT from the job
  ###

  #
  # @return {Error} explaining that nothing was output
  stdout: ->
    return false if @stdout()
    new Error "STDOUT of #{@setup.cmd} should be set but was empty"

  ###
  #3 matchStdout(ok, report)
  __Parameter:__
  - `ok` - `RegExp` which should succeed on STDOUT
  - `report` - `RegExp` to extract text for `Error` message (optional)
  ###

  #
  # @return {Error} with the first lines of output or the `report` result
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

  ###
  #3 matchStderr(ok, report)
  __Parameter:__
  - `ok` - `RegExp` which should succeed on STDERR
  - `report` - `RegExp` to extract text for `Error` message (optional)
  ###

  #
  # @return {Error} with the first lines of output or the `report` result
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

  ###
  #3 notMatchStderr(fail)
  __Parameter:__
  - `fail` - `RegExp` which shouldn't succeed on STDERR
  ###

  #
  # @return {Error} with the part which matched the `fail` definition
  notMatchStderr: (fail) ->
    return false unless res = @stderr().match fail
    if res.input
      res = if res.length > 1 then res[1..-1] else [res[0]]
    new Error "Process #{@setup.cmd} failed with: \"#{res.join '\", \"'}\""

  ###
  #3 stdoutLines(min, max)
  __Parameter:__
  - `min` - `Integer` number of lines which should at least be output
  - `max` - `Integer` number of lines which should be output at max
  ###

  #
  # @return {Error} explaining how many lines the process output
  stdoutLines: (min, max) ->
    lines = if @stdout() then @stdout().split /\n/ else []
    min ?= lines.length
    max ?= lines.length
    return false if min <= lines.length <= max
    new Error "Process #{@setup.cmd} should have #{min}..#{max} number of lines
    but has #{lines.length}"


# Helper Methods
# -------------------------------------------------------------------

# Cat the given text after the first 5 lines.
#
# @param {String} text to be cut if too long
# @return {String} resulting text
abstract = (text) ->
  lines = text.split(/\n/)
  lines = lines[0..5].concat 'and more...' if lines.length > 6
  lines.join '\n'
