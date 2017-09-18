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
        ['test.add_test', 'test.change_test', 'test.delete_test'].forEach (permission) ->
          assert.include permissions, permission
          return

      AuthGroup.forge id: 2
      .fetch withRelated: 'permissions'
      .then (group) -> group.getPermissions()
      .then (permissions) ->
        assert.equal permissions.length, 3
        ['test2.add_test2', 'test2.change_test2', 'test2.delete_test2'].forEach (permission) ->
          assert.include permissions, permission
          return
      return
    return
  return
