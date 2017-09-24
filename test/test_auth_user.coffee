{knex, bookshelf, clean_db} = require './utils'

require('../src') bookshelf

expect = require('chai').expect

AuthUser = bookshelf.model 'Django.Auth.User'

before () -> knex.migrate.latest directory: 'src/migrations/'

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
          expect(permissions).to.have.length 0

    describe 'for superuser', () ->
      it 'should return all permissions', () ->
        AuthUser.forge id: 2
        .fetch()
        .then (user) -> user.getPermissions()
        .then (permissions) ->
          expect(permissions).to.have.length 6

    describe 'for user', () ->
      it 'should return mixed permissions from user groups and user permissions', () ->
        AuthUser.forge id: 3
        .fetch()
        .then (user) -> user.getPermissions()
        .then (permissions) ->
          expect(permissions).to.have.length 4
