let bookshelf, clean_db, knex;

({knex, bookshelf, clean_db} = require('./utils'));

require('..')(bookshelf);

const assert = require('chai').assert;
const Session = bookshelf.model('Django.Session');

before(() => knex.migrate.latest({directory: 'migrations/'}));

after(() => knex.migrate.rollback({directory: 'migrations/'}));

describe('Django.Session', () => {
  before(() => knex.seed.run({directory: 'test/seeds/session/'}));

  after(() => clean_db());

  describe('#toString', () => {
    it('should return string representation of session', async () => {
      const session = await Session.forge({session_key: 'qaz123'}).fetch();
      assert.isString(session.toString());
      assert.equal(session.toString(), 'qaz123');
    });
  });
});
