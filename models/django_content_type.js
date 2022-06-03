module.exports = function(bookshelf) {
  bookshelf.plugin('registry');

  if (bookshelf.model('Django.ContentType') == null) {
    bookshelf.model('Django.ContentType', {
      tableName: 'django_content_type'
    });
  }

  if (bookshelf.collection('Django.ContentTypes') == null) {
    bookshelf.collection('Django.ContentTypes', {
      model: bookshelf.model('Django.ContentType')
    });
  }

  return {
    Model: bookshelf.model('Django.ContentType'),
    Collection: bookshelf.collection('Django.ContentTypes')
  };
};
