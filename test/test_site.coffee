{knex, bookshelf, clean_db} = require './utils'

require('../src') bookshelf

assert = require('chai').assert

Site = bookshelf.model 'Django.Site'

before () -> knex.migrate.latest directory: 'src/migrations/'

describe 'Django.Site', () ->
  before () -> knex.seed.run directory: 'test/seeds/site/'

  after () -> clean_db()

  describe '#toString', () ->
    it 'should return string representation of site', () ->
      Site.forge id: 1
      .fetch()
      .then (site) ->
        assert.isString site.toString()
        assert.equal site.toString(), 'test.example.com'
