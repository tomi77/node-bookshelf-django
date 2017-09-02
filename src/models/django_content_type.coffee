module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('DjangoContentType')?
    bookshelf.model 'DjangoContentType',
      tableName: 'django_content_type'

  unless bookshelf.collection('DjangoContentTypes')?
    bookshelf.collection 'DjangoContentTypes',
      model: bookshelf.model 'DjangoContentType'

  Model: bookshelf.model 'DjangoContentType'
  Collection: bookshelf.collection 'DjangoContentTypes'

