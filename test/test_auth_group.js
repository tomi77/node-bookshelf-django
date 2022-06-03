let bookshelf, clean_db, knex;

({knex, bookshelf, clean_db} = require('./utils'));

require('..')(bookshelf);

const assert = require('chai').assert;
const AuthGroup = bookshelf.model('Django.Auth.Group');
const AuthGroups = bookshelf.collection('Django.Auth.Groups');
const AuthPermissions = bookshelf.collection('Django.Auth.Permissions');

before(() => knex.migrate.latest({directory: 'migrations/'}));

after(() => knex.migrate.rollback({directory: 'migrations/'}));

describe('Django.Auth.Group', () => {
  before(() => knex.seed.run({directory: 'test/seeds/auth_group/'}));

  after(() => clean_db());

  describe('#getPermissions', () => {
    it('should return all permissions', async () => {
      let group = await AuthGroup.forge({id: 1}).fetch({withRelated: 'permissions'});
      let permissions = await group.getPermissions();
      assert.instanceOf(permissions, AuthPermissions);
      assert.equal(permissions.length, 3);
      let expected = ['test.add_test', 'test.change_test', 'test.delete_test'];
      permissions.forEach(permission => assert.include(expected, permission.toString()));

      group = await AuthGroup.forge({id: 2}).fetch({withRelated: 'permissions'});
      permissions = await group.getPermissions();
      assert.instanceOf(permissions, AuthPermissions);
      assert.equal(permissions.length, 3);
      expected = ['test2.add_test2', 'test2.change_test2', 'test2.delete_test2'];
      permissions.forEach(permission => assert.include(expected, permission.toString()));
    });
  });

  describe('#toString', () => {
    it('should return string representation of group', async () => {
      const group = await AuthGroup.forge({id: 1}).fetch();
      assert.isString(group.toString());
      assert.equal(group.toString(), 'group 1');
    });
  });

  describe('#permissions', () => {
    it('should be a reference to Django.Auth.Permissions', async () => {
      const group = await AuthGroup.forge({id: 1}).fetch();
      assert.instanceOf(group.permissions(), AuthPermissions);
      assert.instanceOf(group.related('permissions'), AuthPermissions);
    });
  });
});

describe('Django.Auth.Groups', () => {
  before(() => knex.seed.run({directory: 'test/seeds/auth_groups/'}));

  after(() => clean_db());

  describe('#getPermissions', () => {
    it('should return all permissions', async () => {
      let groups = await AuthGroups.forge().query(qb => qb.where('id', 'in', [1, 2])).fetch();
      let permissions = await groups.getPermissions();
      assert.instanceOf(permissions, AuthPermissions);
      assert.equal(permissions.length, 4);
      let expected = ['test.add_test', 'test.change_test', 'test.delete_test', 'test2.add_test2'];
      permissions.forEach(permission => assert.include(expected, permission.toString()));

      groups = await AuthGroups.forge().query(qb => qb.where('id', 'in', [2, 3])).fetch();
      permissions = await groups.getPermissions();
      assert.instanceOf(permissions, AuthPermissions);
      assert.equal(permissions.length, 4);
      expected = ['test.change_test', 'test2.add_test2', 'test2.delete_test2', 'test2.change_test2'];
      permissions.forEach(permission => assert.include(expected, permission.toString()));
    });
  });
});
