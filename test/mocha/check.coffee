chai = require 'chai'
expect = chai.expect

describe "Check", ->

  config = require 'alinex-config'
  Exec = require '../../src/index'

  before (cb) ->
    @timeout 5000
    Exec.init -> config.init cb


  describe "noExitCode", ->

    it "should succeed", (cb) ->
      Exec.run
        cmd: 'date'
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 0
        expect(exec.result.error, "result error").to.not.exist
        cb()

    it "should fail", (cb) ->
      Exec.run
        cmd: 'cartoon-date'
      , (err, exec) ->
        expect(err, 'error').to.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 127
        expect(exec.result.error, "result error").to.exist
        cb()

  describe "exitCode", ->

    it "should succeed", (cb) ->
      Exec.run
        cmd: 'cartoon-date'
        check:
          exitCode:
            args: [127]
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 127
        expect(exec.result.error, "result error").to.not.exist
        cb()

    it "should fail", (cb) ->
      Exec.run
        cmd: 'date'
        check:
          exitCode:
            args: [127]
      , (err, exec) ->
        expect(err, 'error').to.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 0
        expect(exec.result.error, "result error").to.exist
        cb()

  describe "noStderr", ->

    it "should succeed", (cb) ->
      Exec.run
        cmd: 'date'
        check:
          noStderr: true
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 0
        expect(exec.result.error, "result error").to.not.exist
        cb()

    it "should fail", (cb) ->
      Exec.run
        cmd: 'cartoon-date'
        check:
          noStderr: true
      , (err, exec) ->
        expect(err, 'error').to.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 127
        expect(exec.result.error, "result error").to.exist
        cb()

  describe "noStdout", ->

    it "should succeed", (cb) ->
      Exec.run
        cmd: 'cartoon-date'
        check:
          noStdout: true
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 127
        expect(exec.result.error, "result error").to.not.exist
        cb()

    it "should fail", (cb) ->
      Exec.run
        cmd: 'date'
        check:
          noStdout: true
      , (err, exec) ->
        expect(err, 'error').to.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 0
        expect(exec.result.error, "result error").to.exist
        cb()

  describe "matchStdout", ->

    it "should succeed", (cb) ->
      Exec.run
        cmd: 'ping'
        args: ['-c', 1, '-w', 1, 'localhost']
        check:
          matchStdout:
            args: [/\D0% packet loss/]
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.error, "result error").to.not.exist
        cb()

    it "should fail", (cb) ->
      Exec.run
        cmd: 'ping'
        args: ['-c', 1, '-w', 1, '10.255.205.196']
        check:
          matchStdout:
            args: [/\D0% packet loss/, /\d+% packet loss/]
      , (err, exec) ->
        expect(err, 'error').to.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.error, "result error").to.exist
        cb()

  describe "matchStderr", ->

    it "should succeed", (cb) ->
      Exec.run
        cmd: 'cartoon-date'
        check:
          matchStderr:
            args: [/No such file or directory/]
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 127
        expect(exec.result.error, "result error").to.not.exist
        cb()

    it "should fail", (cb) ->
      Exec.run
        cmd: 'date'
        check:
          matchStderr:
            args: [/No such file or directory/]
      , (err, exec) ->
        expect(err, 'error').to.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 0
        expect(exec.result.error, "result error").to.exist
        cb()

  describe "notMatchStderr", ->

    it "should succeed", (cb) ->
      Exec.run
        cmd: 'date'
        check:
          notMatchStderr:
            args: [/No such file or directory/]
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.error, "result error").to.not.exist
        cb()

    it "should fail", (cb) ->
      Exec.run
        cmd: 'cartoon-date'
        check:
          notMatchStderr:
            args: [/No such file or directory/]
      , (err, exec) ->
        expect(err, 'error').to.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.error, "result error").to.exist
        cb()

  describe "multiple", ->

    it "should succeed", (cb) ->
      Exec.run
        cmd: 'date'
        check:
          noExitCode: true
          noStderr: true
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 0
        expect(exec.result.error, "result error").to.not.exist
        cb()

    it "should fail", (cb) ->
      Exec.run
        cmd: 'cartoon-date'
        check:
          noExitCode: true
          noStderr: true
      , (err, exec) ->
        expect(err, 'error').to.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 127
        expect(exec.result.error, "result error").to.exist
        cb()

    it "should fail on second", (cb) ->
      Exec.run
        cmd: 'cartoon-date'
        check:
          exitCode:
            args: [0, 127]
          noStderr: true
      , (err, exec) ->
        expect(err, 'error').to.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 127
        expect(exec.result.error, "result error").to.exist
        cb()

  describe "retry", ->

    it "should fail with 3 tries", (cb) ->
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
        cb()

  describe "queue", ->

    it.only "should use queue and run it later", (cb) ->
      @timeout 30000
      config.value.exec.priority.level.test =
        maxCpu: 0.01
        maxLoad: 0.01
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
