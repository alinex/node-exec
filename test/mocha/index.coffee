chai = require 'chai'
expect = chai.expect
config = require 'alinex-config'

describe "Base", ->

  Exec = require '../../src/index'

  describe "config", ->

    it "should run the selfcheck on the schema", (cb) ->
      config.selfcheck
        name: 'selfcheck'
        schema: require '../../src/configSchema'
      , cb

