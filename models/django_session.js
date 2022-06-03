module.exports = function(bookshelf) {
  bookshelf.plugin('registry');

  if (bookshelf.model('Django.Session') == null) {
    bookshelf.model('Django.Session', {
      tableName: 'django_session',

      toString() {
        return `${this.get('session_key')}`;
      }
    });
  }

  if (bookshelf.collection('Django.Sessions') == null) {
    bookshelf.collection('Django.Sessions', {
      model: bookshelf.model('Django.Session')
    });
  }

  return {
    Model: bookshelf.model('Django.Session'),
    Collection: bookshelf.collection('Django.Sessions')
  };
};
