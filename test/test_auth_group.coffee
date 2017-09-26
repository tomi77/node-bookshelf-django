{knex, bookshelf, clean_db} = require './utils'

require('../src') bookshelf

assert = require('chai').assert

AuthGroup = bookshelf.model 'Django.Auth.Group'
AuthGroups = bookshelf.collection 'Django.Auth.Groups'
AuthPermissions = bookshelf.collection 'Django.Auth.Permissions'

before () -> knex.migrate.latest directory: 'src/migrations/'

describe 'Django.Auth.Group', () ->
  before () -> knex.seed.run directory: 'test/seeds/auth_group/'

  after () -> clean_db()

  describe '#getPermissions', () ->
    it 'should return all permissions', () ->
      AuthGroup.forge id: 1
      .fetch withRelated: 'permissions'
      .then (group) -> group.getPermissions()
      .then (permissions) ->
        assert.instanceOf permissions, AuthPermissions
        assert.equal permissions.length, 3
        expected = ['test.add_test', 'test.change_test', 'test.delete_test']
        permissions.each (permission) ->
          assert.include expected, permission.toString()

      AuthGroup.forge id: 2
      .fetch withRelated: 'permissions'
      .then (group) -> group.getPermissions()
      .then (permissions) ->
        assert.instanceOf permissions, AuthPermissions
        assert.equal permissions.length, 3
        expected = ['test2.add_test2', 'test2.change_test2', 'test2.delete_test2']
        permissions.each (permission) ->
          assert.include expected, permission.toString()

describe 'Django.Auth.Groups', () ->
  before () -> knex.seed.run directory: 'test/seeds/auth_groups/'

  after () -> clean_db()

  describe '#getPermissions', () ->
    it 'should return all permissions', () ->
      AuthGroups.forge()
      .query (qb) -> qb.where 'id', 'in', [1, 2]
      .fetch()
      .then (groups) -> groups.getPermissions()
      .then (permissions) ->
        assert.instanceOf permissions, AuthPermissions
        assert.equal permissions.length, 4
        expected = ['test.add_test', 'test.change_test', 'test.delete_test', 'test2.add_test2']
        permissions.each (permission) ->
          assert.include expected, permission.toString()

      AuthGroups.forge()
      .query (qb) -> qb.where 'id', 'in', [2, 3]
      .fetch()
      .then (groups) -> groups.getPermissions()
      .then (permissions) ->
        assert.instanceOf permissions, AuthPermissions
        assert.equal permissions.length, 4
        expected = ['test.change_test', 'test2.add_test2', 'test2.delete_test2', 'test2.change_test2']
        permissions.each (permission) ->
          assert.include expected, permission.toString()
