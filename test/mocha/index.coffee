chai = require 'chai'
expect = chai.expect

describe "Base", ->

  Exec = require '../../src/index'

  describe "config", ->

    it "should run the selfcheck on the schema", (cb) ->
      validator = require 'alinex-validator'
      schema = require '../../src/configSchema'
      validator.selfcheck schema, cb

