chai = require 'chai'
expect = chai.expect

describe "Result", ->

  Exec = require '../../src/index'

  before (cb) -> Exec.init cb

  describe "output", ->

    it "should get stdout", (cb) ->
      proc = new Exec
        cmd: 'cat'
        args: ['test/data/poem']
      proc.run (err) ->
        expect(err, 'error').to.not.exist
        expect(proc.result, "result").to.exist
        expect(proc.code, "code").to.equal 0
        expect(proc.stdout(), 'stdout output').to.contain 'The Cat and the Moon'
        cb()

    it "should get stderr", (cb) ->
      proc = new Exec
        cmd: 'cat'
        args: ['test/data/not-existing']
      proc.run (err) ->
        expect(err, 'error').to.not.exist
        expect(proc.result, "result").to.exist
        expect(proc.code, "code").to.not.equal 0
        expect(proc.stderr(), 'stderr output').to.contain 'test/data/not-existing'
        cb()

    it "should get both", (cb) ->
      proc = new Exec
        cmd: 'wc'
        args: ['test/data/poem', 'test/data/not-existing']
      proc.run (err) ->
        expect(err, 'error').to.not.exist
        expect(proc.result, "result").to.exist
        expect(proc.code, "code").to.not.equal 0
        expect(proc.stderr(), 'stderr output').to.contain 'test/data/not-existing'
        expect(proc.stdout().split('\n').length, 'stdout output').to.equal 2
        cb()
