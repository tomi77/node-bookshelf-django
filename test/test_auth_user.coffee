{knex, bookshelf, clean_db} = require './utils'

require('../src') bookshelf

assert = require('chai').assert

AuthUser = bookshelf.model 'Django.Auth.User'
AuthPermissions = bookshelf.collection 'Django.Auth.Permissions'
AuthGroups = bookshelf.collection 'Django.Auth.Groups'

before () -> knex.migrate.latest directory: 'src/migrations/'

after () -> knex.migrate.rollback directory: 'src/migrations/'

describe 'Django.Auth.User', () ->
  before () -> knex.seed.run directory: 'test/seeds/auth_user/'

  after () -> clean_db()

  describe '#getPermissions', () ->
    describe 'for inactive user', () ->
      it 'should return empty permissions list', () ->
        AuthUser.forge id: 1
        .fetch()
        .then (user) -> user.getPermissions()
        .then (permissions) ->
          assert.instanceOf permissions, AuthPermissions
          assert.lengthOf permissions, 0

    describe 'for superuser', () ->
      it 'should return all permissions', () ->
        AuthUser.forge id: 2
        .fetch()
        .then (user) -> user.getPermissions()
        .then (permissions) ->
          assert.instanceOf permissions, AuthPermissions
          assert.lengthOf permissions, 6

    describe 'for user', () ->
      it 'should return mixed permissions from user groups and user permissions', () ->
        AuthUser.forge id: 3
        .fetch()
        .then (user) -> user.getPermissions()
        .then (permissions) ->
          assert.instanceOf permissions, AuthPermissions
          assert.lengthOf permissions, 4

  describe '#toString', () ->
    it 'should return string representation of user', () ->
      AuthUser.forge id: 1
      .fetch()
      .then (user) ->
        assert.isString user.toString()
        assert.equal user.toString(), 'user1'

  describe '#permissions', () ->
    it 'should be a reference to Django.Auth.Permissions', () ->
      AuthUser.forge id: 1
      .fetch()
      .then (user) ->
        assert.instanceOf user.permissions(), AuthPermissions
        assert.instanceOf user.related('permissions'), AuthPermissions

  describe '#groups', () ->
    it 'should be a reference to Django.Auth.AuthGroups', () ->
      AuthUser.forge id: 1
      .fetch()
      .then (user) ->
        assert.instanceOf user.groups(), AuthGroups
        assert.instanceOf user.related('groups'), AuthGroups
