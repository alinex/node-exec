chai = require 'chai'
expect = chai.expect

describe "Local", ->

  Exec = require '../../src/index'

  describe "simple", ->

    it "should run a date command", (cb) ->
      proc = new Exec
        cmd: 'date'
      proc.run (err) ->
        expect(err, 'error').to.not.exist
        expect(proc.result, "result").to.exist
        expect(proc.code, "code").equal 0
        cb()

