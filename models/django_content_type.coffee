module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('DjangoContentType')?
    bookshelf.model 'DjangoContentType',
      tableName: 'django_content_type'

  bookshelf.model 'DjangoContentType'
