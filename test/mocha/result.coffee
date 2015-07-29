chai = require 'chai'
expect = chai.expect

describe "Result", ->

  config = require 'alinex-config'
  Exec = require '../../src/index'

  before (cb) ->
    Exec.setup ->
      config.pushOrigin
        uri: "#{__dirname}/../data/config/exec.yml"
    Exec.init cb

  describe "output", ->

    it "should get stdout", (cb) ->
      exec = new Exec
        cmd: 'cat'
        args: ['test/data/poem']
      exec.run (err) ->
        expect(err, 'error').to.not.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.equal 0
        expect(exec.stdout(), 'stdout output').to.contain 'The Cat and the Moon'
        cb()

    it "should get stderr", (cb) ->
      exec = new Exec
        cmd: 'cat'
        args: ['test/data/not-existing']
      exec.run (err) ->
        expect(err, 'error').to.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.not.equal 0
        expect(exec.stderr(), 'stderr output').to.contain 'test/data/not-existing'
        cb()

    it "should get both", (cb) ->
      exec = new Exec
        cmd: 'wc'
        args: ['test/data/poem', 'test/data/not-existing']
      exec.run (err) ->
        expect(err, 'error').to.exist
        expect(exec.result, "result").to.exist
        expect(exec.result.code, "code").to.not.equal 0
        expect(exec.stderr(), 'stderr output').to.contain 'test/data/not-existing'
        expect(exec.stdout().split('\n').length, 'stdout output').to.equal 2
        cb()
