{knex, bookshelf, clean_db} = require './utils'

require('../src') bookshelf

assert = require('chai').assert

Redirect = bookshelf.model 'Django.Redirect'
Site = bookshelf.model 'Django.Site'

before () -> knex.migrate.latest directory: 'src/migrations/'

after () -> knex.migrate.rollback directory: 'src/migrations/'

describe 'Django.Redirect', () ->
  before () -> knex.seed.run directory: 'test/seeds/redirect/'

  after () -> clean_db()

  describe '#toString', () ->
    it 'should return string representation of redirect', () ->
      Redirect.forge id: 1
      .fetch()
      .then (redirect) ->
        assert.isString redirect.toString()
        assert.equal redirect.toString(), '/old --> /new'

  describe '#site', () ->
    it 'should be a reference to Django.Site', () ->
      Redirect.forge id: 1
      .fetch()
      .then (redirect) ->
        assert.instanceOf redirect.site(), Site
        assert.instanceOf redirect.related('site'), Site
