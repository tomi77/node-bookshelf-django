{knex, bookshelf, clean_db} = require './utils'

require('../src') bookshelf

assert = require('chai').assert

AuthPermission = bookshelf.model 'Django.Auth.Permission'
ContentType = bookshelf.model 'Django.ContentType'

before () -> knex.migrate.latest directory: 'src/migrations/'

after () -> knex.migrate.rollback directory: 'src/migrations/'

describe 'Django.Auth.Permission', () ->
  before () -> knex.seed.run directory: 'test/seeds/auth_permission/'

  after () -> clean_db()

  describe '#toString', () ->
    it 'should format permission in Django style', () ->
      AuthPermission.forge id: 1
      .fetch withRelated: 'contentType'
      .then (permission) ->
        assert.isString permission.toString()
        assert.equal permission.toString(), 'test.add_test'

  describe '#toStringAsync', () ->
    describe 'should format permission in Django style', () ->
      it 'when contentType is loaded', () ->
        AuthPermission.forge id: 1
        .fetch withRelated: 'contentType'
        .then (permission) -> permission.toStringAsync()
        .then (permission) ->
          assert.isString permission
          assert.equal permission, 'test.add_test'

      it 'when contentType is not loaded', () ->
        AuthPermission.forge id: 1
        .fetch()
        .then (permission) -> permission.toStringAsync()
        .then (permission) ->
          assert.isString permission
          assert.equal permission, 'test.add_test'

  describe '#contentType', () ->
    it 'should be a reference to Django.ContentType', () ->
      AuthPermission.forge id: 1
      .fetch()
      .then (permission) ->
        assert.instanceOf permission.contentType(), ContentType
        assert.instanceOf permission.related('contentType'), ContentType

  describe '#stringify', () ->
    it 'should format permission in Django style', () ->
      AuthPermission.forge id: 1
      .fetch withRelated: 'contentType'
      .then AuthPermission.stringify
      .then (permission) ->
        assert.isString permission
        assert.equal permission, 'test.add_test'
