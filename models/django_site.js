module.exports = function(bookshelf) {
  if (bookshelf.model('Django.Site') == null) {
    bookshelf.model('Django.Site', {
      tableName: 'django_site',

      toString() {
        return `${this.get('domain')}`;
      }
    });
  }

  if (bookshelf.collection('Django.Sites') == null) {
    bookshelf.collection('Django.Sites', {
      model: bookshelf.model('Django.Site')
    });
  }

  return {
    Model: bookshelf.model('Django.Site'),
    Collection: bookshelf.collection('Django.Sites')
  };
};
