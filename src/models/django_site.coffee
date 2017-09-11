module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('Django.Site')?
    bookshelf.model 'Django.Site',
      tableName: 'django_site'

  unless bookshelf.collection('Django.Sites')?
    bookshelf.collection 'Django.Sites',
      model: bookshelf.model 'Django.Site'

  Model: bookshelf.model 'Django.Site'
  Collection: bookshelf.collection 'Django.Sites'
