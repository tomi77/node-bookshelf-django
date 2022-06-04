const _ = require('lodash');

module.exports = function(bookshelf) {
  if (bookshelf.model('Django.Auth.Group') == null) {
    require('./auth_permission')(bookshelf);

    bookshelf.model('Django.Auth.Group', {
      tableName: 'auth_group',

      permissions() {
        return this.belongsToMany('Django.Auth.Permissions', 'auth_group_permissions', 'group_id', 'permission_id');
      },

      async getPermissions() {
        const group = await this.load(['permissions', 'permissions.contentType']);
        return group.related('permissions');
      },

      toString() {
        return `${this.get('name')}`;
      }
    });
  }

  if (bookshelf.collection('Django.Auth.Groups') == null) {
    bookshelf.collection('Django.Auth.Groups', {
      model: bookshelf.model('Django.Auth.Group'),

      async getPermissions() {
        const x = await this.mapThen(group => group.getPermissions());
        let permissions = _.reduce(x, (memo, y) => memo.concat(y.models), []);
        permissions = _.uniqBy(permissions, permission => permission.get('id'));
        return await bookshelf.collection('Django.Auth.Permissions').forge(permissions);
      }
    });
  }

  return {
    Model: bookshelf.model('Django.Auth.Group'),
    Collection: bookshelf.collection('Django.Auth.Groups')
  };
};
