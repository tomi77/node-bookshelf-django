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
