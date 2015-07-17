chai = require 'chai'
expect = chai.expect

describe "Retry", ->

  config = require 'alinex-config'
  Exec = require '../../src/index'

  before (cb) ->
    @timeout 5000
    Exec.init -> config.init cb

  beforeEach ->
    Exec.vital = {}

  describe "result", ->

    it "should fail after 3 retries", (cb) ->
      @timeout 10000
      Exec.run
        cmd: 'cartoon-date'
        retry:
          times: 3
          interval: 1000
      , (err, exec) ->
        expect(err, 'error').to.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 127
        expect(exec.result.error, "result error").to.exist
        expect(exec.tries.length, "tries").to.equal 3
        cb()

  describe.only "vital", ->

    it "should use queue and run it through worker", (cb) ->
      @timeout 10000
      config.value.exec.priority.level.test =
        maxCpu: 0.001
        maxLoad: 0.001
        nice: 19
      setTimeout ->
        config.value.exec.priority.level.test =
          maxCpu: 0.9
          maxLoad: 0.9
      , 2000
      Exec.run
        cmd: 'date'
        priority: 'test'
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 0
        expect(exec.result.error, "result error").to.not.exist
        cb()

    it "should use queue and run it later", (cb) ->
      @timeout 30000
      config.value.exec.priority.level.test =
        maxCpu: 0.001
        maxLoad: 0.001
        nice: 19
      setTimeout ->
        config.value.exec.priority.level.test =
          maxCpu: 0.9
          maxLoad: 0.9
      , 10000
      Exec.run
        cmd: 'date'
        priority: 'test'
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 0
        expect(exec.result.error, "result error").to.not.exist
        cb()

  describe "startload", ->

    it.skip "should increase start load", (cb) ->
      @timeout 10000
      config.value.exec.priority.level.test =
        maxCpu: 0.001
        maxLoad: 0.001
        nice: 19
      setTimeout ->
        config.value.exec.priority.level.test =
          maxCpu: 0.9
          maxLoad: 0.9
      , 2000
      Exec.run
        cmd: 'date'
        priority: 'test'
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 0
        expect(exec.result.error, "result error").to.not.exist
        cb()


