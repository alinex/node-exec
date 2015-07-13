chai = require 'chai'
expect = chai.expect

describe "Check", ->

  Exec = require '../../src/index'

  describe "result", ->

    it "should fail on exit code", (cb) ->
      Exec.run
        cmd: 'cartoon-date'
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 127
        expect(exec.result.error, "result error").to.exist
        cb()
