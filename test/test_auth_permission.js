let bookshelf, clean_db, knex;

({knex, bookshelf, clean_db} = require('./utils'));

require('..')(bookshelf);

const assert = require('chai').assert;
const AuthPermission = bookshelf.model('Django.Auth.Permission');
const ContentType = bookshelf.model('Django.ContentType');

before(() => knex.migrate.latest({directory: 'migrations/'}));

after(() => knex.migrate.rollback({directory: 'migrations/'}));

describe('Django.Auth.Permission', () => {
  before(() => knex.seed.run({directory: 'test/seeds/auth_permission/'}));

  after(() => clean_db());

  describe('#toString', () => {
    it('should format permission in Django style', async () => {
      const permission = await AuthPermission.forge({id: 1}).fetch({withRelated: 'contentType'});
      assert.isString(permission.toString());
      assert.equal(permission.toString(), 'test.add_test');
    });
  });

  describe('#toStringAsync', () => {
    describe('should format permission in Django style', () => {
      it('when contentType is loaded', async () => {
        let permission = await AuthPermission.forge({id: 1}).fetch({withRelated: 'contentType'});
        permission = await permission.toStringAsync();
        assert.isString(permission);
        assert.equal(permission, 'test.add_test');
      });

      it('when contentType is not loaded', async () => {
        let permission = await AuthPermission.forge({id: 1}).fetch();
        permission = await permission.toStringAsync();
        assert.isString(permission);
        assert.equal(permission, 'test.add_test');
      });
    });
  });

  describe('#contentType', () => {
    it('should be a reference to Django.ContentType', async () => {
      const permission = await AuthPermission.forge({id: 1}).fetch();
      assert.instanceOf(permission.contentType(), ContentType);
      assert.instanceOf(permission.related('contentType'), ContentType);
    });
  });

  describe('#stringify', () => {
    it('should format permission in Django style', async () => {
      let permission = await AuthPermission.forge({id: 1}).fetch({withRelated: 'contentType'});
      permission = AuthPermission.stringify(permission);
      assert.isString(permission);
      assert.equal(permission, 'test.add_test');
    });
  });
});
