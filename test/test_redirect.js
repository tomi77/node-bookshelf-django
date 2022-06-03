let bookshelf, clean_db, knex;

({knex, bookshelf, clean_db} = require('./utils'));

require('..')(bookshelf);

const assert = require('chai').assert;
const Redirect = bookshelf.model('Django.Redirect');
const Site = bookshelf.model('Django.Site');

before(() => knex.migrate.latest({directory: 'migrations/'}));

after(() => knex.migrate.rollback({directory: 'migrations/'}));

describe('Django.Redirect', () => {
  before(() => knex.seed.run({directory: 'test/seeds/redirect/'}));

  after(() => clean_db());

  describe('#toString', () => {
    it('should return string representation of redirect', async () => {
      const redirect = await Redirect.forge({id: 1}).fetch();
      assert.isString(redirect.toString());
      assert.equal(redirect.toString(), '/old --> /new');
    });
  });

  describe('#site', () => {
    it('should be a reference to Django.Site', async () => {
      const redirect = await Redirect.forge({id: 1}).fetch();
      assert.instanceOf(redirect.site(), Site);
      assert.instanceOf(redirect.related('site'), Site);
    });
  });
});
