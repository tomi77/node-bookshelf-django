let bookshelf, clean_db, knex;

({knex, bookshelf, clean_db} = require('./utils'));

require('..')(bookshelf);

const assert = require('chai').assert;
const FlatPage = bookshelf.model('Django.FlatPage');
const Sites = bookshelf.collection('Django.Sites');

before(() => knex.migrate.latest({directory: 'migrations/'}));

after(() => knex.migrate.rollback({directory: 'migrations/'}));

describe('Django.FlatPage', () => {
  before(() => knex.seed.run({directory: 'test/seeds/flatpage/'}));

  after(() => clean_db());

  describe('#toString', () => {
    it('should return string representation of flatpage', async () => {
      const flatpage = await FlatPage.forge({id: 1}).fetch();
      assert.isString(flatpage.toString());
      assert.equal(flatpage.toString(), 'https://www.example.com/ -- Example');
    });
  });

  describe('#sites', () => {
    it('should be a reference to Django.Sites', async () => {
      const flatpage = await FlatPage.forge({id: 1}).fetch();
      assert.instanceOf(flatpage.sites(), Sites);
      assert.instanceOf(flatpage.related('sites'), Sites);
    });
  });
});
