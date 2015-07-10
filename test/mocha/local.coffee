chai = require 'chai'
expect = chai.expect
async = require 'alinex-async'

describe "Local", ->

  Exec = require '../../src/index'

  before (cb) ->
    @timeout 5000
    Exec.init cb

  describe "command", ->

    it "should run date", (cb) ->
      exec = new Exec
        cmd: 'date'
      exec.run (err) ->
        expect(err, 'error').to.not.exist
        expect(exec.code, "code").equal 0
        expect(exec.result, "result").to.exist
        cb()

    it "should run date (direct)", (cb) ->
      Exec.run
        cmd: 'date'
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.code, "code").equal 0
        expect(exec.result, "result").to.exist
        cb()

    it "should allow arguments", (cb) ->
      now = (new Date()).toISOString()
      Exec.run
        cmd: 'date'
        args: [
          '--iso-8601'
        ]
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.code, "code").equal 0
        expect(exec.result[0][1], "result stdout").to.equal now[0..9]
        cb()

    it "should allow changed working directory", (cb) ->
      Exec.run
        cmd: 'pwd'
        cwd: '/etc'
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.code, "code").equal 0
        expect(exec.result[0][1], "result stdout").to.equal '/etc'
        cb()

    it "should change environment", (cb) ->
      Exec.run
        cmd: 'sh'
        args: [ '-c', 'echo $MY_ENV' ]
        env:
          MY_ENV: 'alex'
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.code, "code").equal 0
        expect(exec.result[0][1], "result stdout").to.equal 'alex'
        cb()

    it "should not fail on ulimit", (cb) ->
      @timeout 30000
      config = require 'alinex-config'
      Exec.init -> config.init ->
        async.each [1..1000], (n, cb) ->
          Exec.run
            cmd: 'sleep'
            args: [ 1 ]
          , (err, exec) ->
            expect(err, 'error').to.not.exist
            expect(exec.code, "code").equal 0
            cb()
        , (err) ->
          cb()

    # set uid not testable
    # set gid not testable

    it "should use priorities", (cb) ->
      @timeout 50000
      config = require 'alinex-config'
      level = Object.keys config.get 'exec/priority/level'
      async.map level, (prio, cb) ->
        Exec.run
          cmd: 'test/data/fibonacci'
          args: [15]
          priority: prio
        , cb
      , (err, results) ->
        for exec in results
          console.log exec.process.end
        expect(results[0].process.end).to.be.above results[1].process.end
        expect(results[1].process.end).to.be.above results[2].process.end
        cb()

    # retry
    # checks