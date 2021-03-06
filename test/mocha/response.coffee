chai = require 'chai'
expect = chai.expect
### eslint-env node, mocha ###

describe "Response check", ->

  config = require 'alinex-config'
  Exec = require '../../src/index'

  before (cb) ->
    @timeout 50000
    Exec.setup ->
      config.pushOrigin
        uri: "#{__dirname}/../data/config/exec.yml"
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
        cmd: 'ls'
        args: ['/path-is-not-existing-on-this-system']
        check:
          noStderr: true
      , (err, exec) ->
        expect(err, 'error').to.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 2
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

  describe "stderr", ->

    it "should succeed", (cb) ->
      Exec.run
        cmd: 'ls'
        args: ['/path-is-not-existing-on-this-system']
        check:
          stderr: true
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 2
        expect(exec.result.error, "result error").to.not.exist
        cb()

    it "should fail", (cb) ->
      Exec.run
        cmd: 'date'
        check:
          stderr: true
      , (err, exec) ->
        expect(err, 'error').to.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 0
        expect(exec.result.error, "result error").to.exist
        cb()

  describe "stdout", ->

    it "should succeed", (cb) ->
      Exec.run
        cmd: 'date'
        check:
          stdout: true
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
          stdout: true
      , (err, exec) ->
        expect(err, 'error').to.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 127
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
        cmd: 'ls'
        args: ['/path-is-not-existing-on-this-system']
        check:
          matchStderr:
            args: [/No such file or directory/]
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 2
        expect(exec.result.error, "result error").to.not.exist
        cb()

    it "should fail", (cb) ->
      Exec.run
        cmd: 'ls'
        args: ['/path-is-not-existing-on-this-system']
        check:
          matchStderr:
            args: [/Heap Memory/]
      , (err, exec) ->
        expect(err, 'error').to.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 2
        expect(exec.result.error, "result error").to.exist
        cb()

  describe "notMatchStderr", ->

    it "should succeed", (cb) ->
      Exec.run
        cmd: 'ls'
        args: ['/path-is-not-existing-on-this-system']
        check:
          notMatchStderr:
            args: [/Heap Memory/]
      , (err, exec) ->
        expect(err, 'error').to.not.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.error, "result error").to.not.exist
        cb()

    it "should fail", (cb) ->
      Exec.run
        cmd: 'ls'
        args: ['/path-is-not-existing-on-this-system']
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
        cmd: 'ls'
        args: ['/path-is-not-existing-on-this-system']
        check:
          exitCode:
            args: [0, 2]
          noStderr: true
      , (err, exec) ->
        expect(err, 'error').to.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 2
        expect(exec.result.error, "result error").to.exist
        cb()

  describe "stdoutLines", ->

    it "should succeed", (cb) ->
      Exec.run
        cmd: 'date'
        check:
          stdoutLines:
            args: 1
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
          stdoutLines:
            args: 1
      , (err, exec) ->
        expect(err, 'error').to.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 127
        expect(exec.result.error, "result error").to.exist
        cb()
