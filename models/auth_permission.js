const Promise = require('bluebird');

module.exports = function(bookshelf) {
  bookshelf.plugin('registry');

  if (bookshelf.model('Django.Auth.Permission') == null) {
    require('./django_content_type')(bookshelf);

    bookshelf.model('Django.Auth.Permission', {
      tableName: 'auth_permission',

      contentType() {
        return this.belongsTo('Django.ContentType', 'content_type_id');
      },

      toString() {
        return `${this.related('contentType').get('app_label')}.${this.get('codename')}`;
      },

      async toStringAsync() {
        const permission = await (this.related('contentType').get('app_label') == null ? this.load('contentType') : Promise.resolve(this));
        return `${permission}`;
      }
    }, {
      stringify(permission) {
        return permission.toString();
      }
    });
  }

  if (bookshelf.collection('Django.Auth.Permissions') == null) {
    bookshelf.collection('Django.Auth.Permissions', {
      model: bookshelf.model('Django.Auth.Permission')
    });
  }

  return {
    Model: bookshelf.model('Django.Auth.Permission'),
    Collection: bookshelf.collection('Django.Auth.Permissions')
  };
};
