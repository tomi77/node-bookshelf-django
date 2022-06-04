module.exports = function(bookshelf) {
  if (bookshelf.model('Django.FlatPage') == null) {
    require('./django_site')(bookshelf);

    bookshelf.model('Django.FlatPage', {
      tableName: 'django_flatpage',

      sites() {
        return this.belongsToMany('Django.Sites', 'django_flatpage_sites', 'flatpage_id', 'site_id');
      },

      toString() {
        return `${this.get('url')} -- ${this.get('title')}`;
      }
    });
  }

  if (bookshelf.collection('Django.FlatPages') == null) {
    bookshelf.collection('Django.FlatPages', {
      model: bookshelf.model('Django.FlatPage')
    });
  }

  return {
    Model: bookshelf.model('Django.FlatPage'),
    Collection: bookshelf.collection('Django.FlatPages')
  };
};
