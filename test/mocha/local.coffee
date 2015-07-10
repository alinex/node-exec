chai = require 'chai'
expect = chai.expect
async = require 'alinex-async'

describe "Local", ->

  Exec = require '../../src/index'

  describe "command", ->

    it "should run date", (cb) ->
      proc = new Exec
        cmd: 'date'
      proc.run (err) ->
        expect(err, 'error').to.not.exist
        expect(proc.code, "code").equal 0
        expect(proc.result, "result").to.exist
        cb()

    it "should run date (direct)", (cb) ->
      Exec.run
        cmd: 'date'
      , (err, proc) ->
        expect(err, 'error').to.not.exist
        expect(proc.code, "code").equal 0
        expect(proc.result, "result").to.exist
        cb()

    it "should allow arguments", (cb) ->
      now = (new Date()).toISOString()
      Exec.run
        cmd: 'date'
        args: [
          '--iso-8601'
        ]
      , (err, proc) ->
        expect(err, 'error').to.not.exist
        expect(proc.code, "code").equal 0
        expect(proc.result[0][1], "result stdout").to.equal now[0..9]
        cb()

    it "should allow changed working directory", (cb) ->
      Exec.run
        cmd: 'pwd'
        cwd: '/etc'
      , (err, proc) ->
        expect(err, 'error').to.not.exist
        expect(proc.code, "code").equal 0
        expect(proc.result[0][1], "result stdout").to.equal '/etc'
        cb()

    it "should change environment", (cb) ->
      Exec.run
        cmd: 'sh'
        args: [ '-c', 'echo $MY_ENV' ]
        env:
          MY_ENV: 'alex'
      , (err, proc) ->
        expect(err, 'error').to.not.exist
        expect(proc.code, "code").equal 0
        expect(proc.result[0][1], "result stdout").to.equal 'alex'
        cb()

    it.only "should not fail on ulimit", (cb) ->
      @timeout 20000
      config = require 'alinex-config'
      Exec.init -> config.init ->
        async.each [1..1000], (n, cb) ->
          Exec.run
            cmd: 'sleep'
            args: [ 3 ]
          , (err, proc) ->
            expect(err, 'error').to.not.exist
            expect(proc.code, "code").equal 0
            cb()
        , (err) ->
          cb()

    # set uid not testable
    # set gid not testable

    # priority
    # retry
    # checks