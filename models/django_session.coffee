module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('DjangoSession')?
    bookshelf.model 'DjangoSession',
      tableName: 'django_session'

  bookshelf.model 'DjangoSession'
