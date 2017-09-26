{knex, bookshelf, clean_db} = require './utils'

require('../src') bookshelf

assert = require('chai').assert

FlatPage = bookshelf.model 'Django.FlatPage'
Sites = bookshelf.collection 'Django.Sites'

before () -> knex.migrate.latest directory: 'src/migrations/'

after () -> knex.migrate.rollback directory: 'src/migrations/'

describe 'Django.FlatPage', () ->
  before () -> knex.seed.run directory: 'test/seeds/flatpage/'

  after () -> clean_db()

  describe '#toString', () ->
    it 'should return string representation of flatpage', () ->
      FlatPage.forge id: 1
      .fetch()
      .then (flatpage) ->
        assert.isString flatpage.toString()
        assert.equal flatpage.toString(), 'https://www.example.com/ -- Example'

  describe '#sites', () ->
    it 'should be a reference to Django.Sites', () ->
      FlatPage.forge id: 1
      .fetch()
      .then (flatpage) ->
        assert.instanceOf flatpage.sites(), Sites
        assert.instanceOf flatpage.related('sites'), Sites
