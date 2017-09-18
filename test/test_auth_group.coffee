knex = require('knex')
  client: 'sqlite3'
  connection:
    filename: ':memory:'
  useNullAsDefault: yes

bookshelf = require('bookshelf') knex

require('../src') bookshelf

assert = require('chai').assert

before () -> knex.migrate.latest directory: 'src/migrations/'

describe 'Django.Auth.Group', () ->
  before () -> knex.seed.run directory: 'test/seeds/auth_group/'

  describe '#getPermissions', () ->
    it 'should return all permissions', () ->
      AuthGroup = bookshelf.model 'Django.Auth.Group'

      AuthGroup.forge id: 1
      .fetch withRelated: 'permissions'
      .then (group) -> group.getPermissions()
      .then (permissions) ->
        assert.equal permissions.length, 3
        excepted = ['test.add_test', 'test.change_test', 'test.delete_test']
        permissions.each (permission) ->
          assert.include expected, permission.toString()
          return

      AuthGroup.forge id: 2
      .fetch withRelated: 'permissions'
      .then (group) -> group.getPermissions()
      .then (permissions) ->
        assert.equal permissions.length, 3
        expected = ['test2.add_test2', 'test2.change_test2', 'test2.delete_test2']
        permissions.each (permission) ->
          assert.include expected, permission.toString()
          return
      return
    return
  return

describe 'Django.Auth.Groups', () ->
  before () -> knex.seed.run directory: 'test/seeds/auth_groups/'

  describe '#getPermissions', () ->
    it 'should return all permissions', () ->
      AuthGroups = bookshelf.collection 'Django.Auth.Groups'

      new AuthGroups()
      .query (qb) -> qb.where 'id', 'in', [1, 2]
      .fetch()
      .then (groups) -> groups.getPermissions()
      .then (permissions) ->
        assert.equal permissions.length, 4
        expected = ['test.add_test', 'test.change_test', 'test.delete_test', 'test2.add_test2']
        permissions.each (permission) ->
          assert.include expected, permission.toString()
          return

      new AuthGroups()
      .query (qb) -> qb.where 'id', 'in', [2, 3]
      .fetch()
      .then (groups) -> groups.getPermissions()
      .then (permissions) ->
        assert.equal permissions.length, 4
        expected = ['test.change_test', 'test2.add_test2', 'test2.delete_test2', 'test2.change_test2']
        permissions.each (permission) ->
          assert.include expected, permission.toString()
          return
      return
    return
  return
