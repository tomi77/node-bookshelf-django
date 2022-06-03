let bookshelf, clean_db, knex;

({knex, bookshelf, clean_db} = require('./utils'));

require('..')(bookshelf);

const assert = require('chai').assert;
const Site = bookshelf.model('Django.Site');

before(() => knex.migrate.latest({directory: 'migrations/'}));

after(() => knex.migrate.rollback({directory: 'migrations/'}));

describe('Django.Site', () => {
  before(() => knex.seed.run({directory: 'test/seeds/site/'}));

  after(() => clean_db());

  describe('#toString', () => {
    it('should return string representation of site', async () => {
      const site = await Site.forge({id: 1}).fetch();
      assert.isString(site.toString());
      assert.equal(site.toString(), 'test.example.com');
    });
  });
});
