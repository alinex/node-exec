chai = require 'chai'
expect = chai.expect

describe "Local", ->

  Exec = require '../../src/index'

  describe "command", ->

    it "should run date", (cb) ->
      proc = new Exec
        cmd: 'date'
      proc.run (err) ->
        expect(err, 'error').to.not.exist
        expect(proc.result, "result").to.exist
        expect(proc.code, "code").equal 0
        cb()

    it "should run date (direct)", (cb) ->
      Exec.run
        cmd: 'date'
      , (err, proc) ->
        expect(err, 'error').to.not.exist
        expect(proc.result, "result").to.exist
        expect(proc.code, "code").equal 0
        cb()

