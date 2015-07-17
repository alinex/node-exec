chai = require 'chai'
expect = chai.expect

describe "Base", ->

  Exec = require '../../src/index'

  before (cb) ->
    @timeout 5000
    Exec.init cb

  describe "config", ->

    it "should run the selfcheck on the schema", (cb) ->
      validator = require 'alinex-validator'
      schema = require '../../src/configSchema'
      validator.selfcheck schema, cb

    it "should initialize config", (cb) ->
      @timeout 4000
      Exec.init (err) ->
        expect(err, 'init error').to.not.exist
        config = require 'alinex-config'
        config.init (err) ->
          expect(err, 'load error').to.not.exist
          conf = config.get '/exec'
          expect(conf, 'config').to.exist
          expect(conf.retry.error.times, 'retry num').to.be.above -1
          cb()

  describe "command", ->

    it "should run with extra arguments", (cb) ->
      now = (new Date()).toISOString()
      Exec.run
        cmd: 'date'
        args: ['--iso-8601']
      , (err, exec) ->
        expect(exec.setup.cmd, 'cmd').to.equal 'date'
        expect(exec.setup.args, 'args').to.deep.equal ['--iso-8601']
        expect(err, 'error').to.not.exist
        expect(exec.result.lines[0][1], "result stdout").to.equal now[0..9]
        expect(exec.result.code, "code").equal 0
        cb()

    it "should split arguments", (cb) ->
      now = (new Date()).toISOString()
      Exec.run
        cmd: 'date --iso-8601'
      , (err, exec) ->
        expect(exec.setup.cmd, 'cmd').to.equal 'date'
        expect(exec.setup.args, 'args').to.deep.equal ['--iso-8601']
        expect(err, 'error').to.not.exist
        expect(exec.result.lines[0][1], "result stdout").to.equal now[0..9]
        expect(exec.result.code, "code").equal 0
        cb()
