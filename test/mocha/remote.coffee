chai = require 'chai'
expect = chai.expect
async = require 'alinex-async'

describe "Remote", ->

  Exec = require '../../src/index'

  before (cb) ->
    @timeout 8000
    Exec.init cb

  describe "command", ->

    it.only "should run date", (cb) ->
      exec = new Exec
        remote: 'server1'
        cmd: 'date'
      exec.run (err) ->
        expect(err, 'error').to.not.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").equal 0
        cb()
