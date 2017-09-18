knex = require('knex')
  client: 'sqlite3'
  connection:
    filename: ':memory:'
  useNullAsDefault: yes

bookshelf = require('bookshelf') knex

require('../src') bookshelf

assert = require('chai').assert

before () -> knex.migrate.latest directory: 'src/migrations/'

describe 'Django.Auth.Permission', () ->
  before () -> knex.seed.run directory: 'test/seeds/auth_permission/'

  describe '#toString', () ->
    it 'should format permission in Django style', () ->
      AuthPermission = bookshelf.model 'Django.Auth.Permission'

      AuthPermission.forge id: 1
      .fetch withRelated: 'contentType'
      .then (permission) ->
        assert.equal permission.toString(), 'test.add_test'
        return
      return

  describe '#toStringAsync', () ->
    describe 'should format permission in Django style', () ->
      it 'when contentType is loaded', () ->
        AuthPermission = bookshelf.model 'Django.Auth.Permission'

        AuthPermission.forge id: 1
        .fetch withRelated: 'contentType'
        .then (permission) -> permission.toStringAsync()
        .then (permission) ->
          assert.equal permission, 'test.add_test'
          return
        return

      it 'when contentType is not loaded', () ->
        AuthPermission = bookshelf.model 'Django.Auth.Permission'

        AuthPermission.forge id: 1
        .fetch()
        .then (permission) -> permission.toStringAsync()
        .then (permission) ->
          assert.equal permission, 'test.add_test'
          return
        return
      return
    return

  describe '#stringify', () ->
    it 'should format permission in Django style', () ->
      AuthPermission = bookshelf.model 'Django.Auth.Permission'

      AuthPermission.forge id: 1
      .fetch withRelated: 'contentType'
      .then AuthPermission.stringify
      .then (permission) ->
        assert.equal permission, 'test.add_test'
        return
      return
    return
  return
return
