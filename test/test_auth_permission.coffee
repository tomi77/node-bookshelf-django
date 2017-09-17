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
    describe 'should format permission in Django style', () ->
      it 'when contentType is loaded', () ->
        AuthPermission = bookshelf.model 'Django.Auth.Permission'

        AuthPermission.forge id: 1
        .fetch withRelated: 'contentType'
        .then (permission) -> permission.toString()
        .then (permission) ->
          assert.equal permission, 'test.add_test'
          return
        return

      it 'when contentType is not loaded', () ->
        AuthPermission = bookshelf.model 'Django.Auth.Permission'

        AuthPermission.forge id: 1
        .fetch()
        .then (permission) -> permission.toString()
        .then (permission) ->
          assert.equal permission, 'test.add_test'
          return
        return
      return
    return
  return

describe 'Django.Auth.Permissions', () ->
  before () -> knex.seed.run directory: 'test/seeds/auth_permissions/'

  describe '#getPermissions', () ->
    it 'should return all permissions', () ->
      AuthPermissions = bookshelf.collection 'Django.Auth.Permissions'

      AuthPermissions.forge()
      .fetch()
      .then (permissions) -> permissions.getPermissions()
      .then (permissions) ->
        assert.equal permissions.length, 3
        ['test.add_test', 'test.change_test', 'test.delete_test'].forEach (permission) ->
          assert.include permissions, permission
          return
    return
  return
return
