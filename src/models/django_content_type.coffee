module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('Django.ContentType')?
    bookshelf.model 'Django.ContentType',
      tableName: 'django_content_type'

  unless bookshelf.collection('Django.ContentTypes')?
    bookshelf.collection 'Django.ContentTypes',
      model: bookshelf.model 'Django.ContentType'

  Model: bookshelf.model 'Django.ContentType'
  Collection: bookshelf.collection 'Django.ContentTypes'
