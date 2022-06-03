var bookshelf, clean_db, knex;

({knex, bookshelf, clean_db} = require('./utils'));

require('..')(bookshelf);

const assert = require('chai').assert;
const AuthUser = bookshelf.model('Django.Auth.User');
const AuthPermissions = bookshelf.collection('Django.Auth.Permissions');
const AuthGroups = bookshelf.collection('Django.Auth.Groups');

before(() => knex.migrate.latest({directory: 'migrations/'}));

after(() => knex.migrate.rollback({directory: 'migrations/'}));

describe('Django.Auth.User', () => {
  before(() => knex.seed.run({directory: 'test/seeds/auth_user/'}));

  after(() => clean_db());

  describe('#getPermissions', () => {
    describe('for inactive user', () => {
      it('should return empty permissions list', async () => {
        const user = await AuthUser.forge({id: 1}).fetch();
        const permissions = await user.getPermissions();
        assert.instanceOf(permissions, AuthPermissions);
        assert.lengthOf(permissions, 0);
      });
    });

    describe('for superuser', () => {
      it('should return all permissions', async () => {
        const user = await AuthUser.forge({id: 2}).fetch();
        const permissions = await user.getPermissions();
        assert.instanceOf(permissions, AuthPermissions);
        assert.lengthOf(permissions, 6);
      });
    });

    describe('for user', () => {
      it('should return mixed permissions from user groups and user permissions', async () => {
        const user = await AuthUser.forge({id: 3}).fetch();
        const permissions = await user.getPermissions();
        assert.instanceOf(permissions, AuthPermissions);
        assert.lengthOf(permissions, 4);
      });
    });
  });

  describe('#toString', () => {
    it('should return string representation of user', async () => {
      const user = await AuthUser.forge({id: 1}).fetch();
      assert.isString(user.toString());
      assert.equal(user.toString(), 'user1');
    });
  });

  describe('#permissions', () => {
    it('should be a reference to Django.Auth.Permissions', async () => {
      const user = await AuthUser.forge({id: 1}).fetch();
      assert.instanceOf(user.permissions(), AuthPermissions);
      assert.instanceOf(user.related('permissions'), AuthPermissions);
    });
  });

  describe('#groups', () => {
    it('should be a reference to Django.Auth.AuthGroups', async () => {
      const user = await AuthUser.forge({id: 1}).fetch();
      assert.instanceOf(user.groups(), AuthGroups);
      assert.instanceOf(user.related('groups'), AuthGroups);
    });
  });
});
