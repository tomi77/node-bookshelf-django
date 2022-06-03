const Promise = require('bluebird');

module.exports = function(bookshelf) {
  bookshelf.plugin('registry');

  if (bookshelf.model('Django.Auth.User') == null) {
    require('./auth_permission')(bookshelf);
    require('./auth_group')(bookshelf);

    bookshelf.model('Django.Auth.User', {
      tableName: 'auth_user',

      permissions() {
        return this.belongsToMany('Django.Auth.Permissions', 'auth_user_user_permissions', 'user_id', 'permission_id');
      },

      groups() {
        return this.belongsToMany('Django.Auth.Groups', 'auth_user_groups', 'user_id', 'group_id');
      },

      toString() {
        return `${this.get('username')}`;
      },

      async getPermissions() {
        if (!this.get('is_active')) {
          return bookshelf.collection('Django.Auth.Permissions').forge();
        } else if (this.get('is_superuser')) {
          return await bookshelf.collection('Django.Auth.Permissions').forge().fetch({withRelated: 'contentType'});
        } else {
          const user = await this.load(['permissions', 'permissions.contentType', 'groups', 'groups.permissions', 'groups.permissions.contentType']);
          let groups_permissions, permissions;
          [groups_permissions, permissions] = await Promise.all([user.related('groups').getPermissions(), user.related('permissions')]);
          return permissions.add(groups_permissions.models);
        }
      }
    });
  }

  if (bookshelf.collection('Django.Auth.Users') == null) {
    bookshelf.collection('Django.Auth.Users', {
      model: bookshelf.model('Django.Auth.User')
    });
  }

  return {
    Model: bookshelf.model('Django.Auth.User'),
    Collection: bookshelf.collection('Django.Auth.Users')
  };
};
