chai = require 'chai'
expect = chai.expect
### eslint-env node, mocha ###
async = require 'async'
fs = require 'fs'

describe "Remote", ->
  @timeout 20000

  config = require 'alinex-config'
  Exec = require '../../src/index'

  before (cb) ->
    @timeout 50000
    Exec.setup ->
      config.pushOrigin
        uri: "#{__dirname}/../data/config/*.yml"
    Exec.init cb

  describe.only "connection", ->

    it "should fail if connection is impossible", (cb) ->
      return @skip() unless fs.existsSync '/home/alex/.ssh/id_rsa'
      exec = new Exec
        remote: 'server2'
        cmd: 'date'
      exec.run (err) ->
        expect(err, 'error').to.exist
        expect(exec.result, "result").to.not.exist
        cb()

    it "should fail for wrong remote", (cb) ->
      Exec.run
        remote: 'notexisting'
        cmd: 'date'
      , (err) ->
        console.log err
        expect(err, 'error').to.exist
        cb()

  describe "command", ->

    it "should run date", (cb) ->
      return @skip() unless fs.existsSync '/home/alex/.ssh/id_rsa'
      exec = new Exec
        remote: 'server1'
        cmd: 'date'
        priority: 'high'
      exec.run (err) ->
        expect(err, 'error').to.not.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").equal 0
        cb()

    it "should run date immediately", (cb) ->
      return @skip() unless fs.existsSync '/home/alex/.ssh/id_rsa'
      exec = new Exec
        remote: 'server1'
        cmd: 'date'
        priority: 'immediately'
      exec.run (err) ->
        expect(err, 'error').to.not.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").equal 0
        cb()

    it "should allow arguments", (cb) ->
      return @skip() unless fs.existsSync '/home/alex/.ssh/id_rsa'
      now = (new Date()).toISOString()
      Exec.run
        remote: 'server1'
        cmd: 'date'
        args: [
          '--iso-8601'
        ]
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.result.lines[0][1], "result stdout").to.equal now[0..9]
        expect(exec.result.code, "code").equal 0
        cb()

    it "should allow changed working directory", (cb) ->
      return @skip() unless fs.existsSync '/home/alex/.ssh/id_rsa'
      Exec.run
        remote: 'server1'
        cmd: 'pwd'
        cwd: '/etc'
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.result.lines[0][1], "result stdout").to.equal '/etc'
        expect(exec.result.code, "code").equal 0
        cb()

    it "should change environment", (cb) ->
      return @skip() unless fs.existsSync '/home/alex/.ssh/id_rsa'
      Exec.run
        remote: 'server1'
        cmd: 'sh'
        args: [ '-c', 'echo $MY_ENV' ]
        env:
          MY_ENV: 'alex'
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.result.lines[0][1], "result stdout").to.equal 'alex'
        expect(exec.result.code, "code").equal 0
        cb()

    it "should not fail on ulimit", (cb) ->
      return @skip() unless fs.existsSync '/home/alex/.ssh/id_rsa'
      @timeout 60000
      config = require 'alinex-config'
      Exec.init -> config.init ->
        async.each [1..200], (n, cb) ->
          Exec.run
            remote: 'server1'
            cmd: 'sleep'
            args: [ 1 ]
          , (err, exec) ->
            expect(err, 'error').to.not.exist
            cb()
            expect(exec.result.code, "code").equal 0
        , ->
          cb()

    it "should use priorities", (cb) ->
      return @skip() unless fs.existsSync '/home/alex/.ssh/id_rsa'
      # not really showing a change but worḱing
      @timeout 120000
      config = require 'alinex-config'
      level = Object.keys config.get 'exec/priority/level'
      async.map level, (prio, cb) ->
        Exec.run
          remote: 'server1'
          cmd: __dirname + '/../../test/data/fibonacci'
          args: [15]
          priority: prio
        , cb
      , (err, results) ->
        expect(results[0].process.end + 100).to.be.not.below results[1].process.end
        cb()

    it "should support timeout", (cb) ->
      @timeout 25000
      return @skip() unless fs.existsSync '/home/alex/.ssh/id_rsa'
      exec = new Exec
        remote: 'server1'
        cmd: 'sleep'
        args: [300]
        timeout: 1000
        check:
          noExitCode: true
      exec.run (err) ->
        expect(err, 'error').to.exist
        cb()
