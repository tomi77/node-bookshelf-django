{knex, bookshelf, clean_db} = require './utils'

require('../src') bookshelf

assert = require('chai').assert

Session = bookshelf.model 'Django.Session'

before () -> knex.migrate.latest directory: 'src/migrations/'

after () -> knex.migrate.rollback directory: 'src/migrations/'

describe 'Django.Session', () ->
  before () -> knex.seed.run directory: 'test/seeds/session/'

  after () -> clean_db()

  describe '#toString', () ->
    it 'should return string representation of session', () ->
      Session.forge session_key: 'qaz123'
      .fetch()
      .then (session) ->
        assert.isString session.toString()
        assert.equal session.toString(), 'qaz123'
