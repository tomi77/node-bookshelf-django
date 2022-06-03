module.exports = function(bookshelf) {
  bookshelf.plugin('registry');

  if (bookshelf.model('Django.Redirect') == null) {
    require('./django_site')(bookshelf);

    bookshelf.model('Django.Redirect', {
      tableName: 'django_redirect',

      site() {
        return this.belongsTo('Django.Site', 'site_id');
      },

      toString() {
        return `${this.get('old_path')} --> ${this.get('new_path')}`;
      }
    });
  }

  if (bookshelf.collection('Django.Redirects') == null) {
    bookshelf.collection('Django.Redirects', {
      model: bookshelf.model('Django.Redirect')
    });
  }

  return {
    Model: bookshelf.model('Django.Redirect'),
    Collection: bookshelf.collection('Django.Redirects')
  };
};
