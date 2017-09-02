module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('DjangoSession')?
    bookshelf.model 'DjangoSession',
      tableName: 'django_session'

  unless bookshelf.collection('DjangoSessions')?
    bookshelf.collection 'DjangoSessions',
      model: bookshelf.model 'DjangoSession'

  Model: bookshelf.model 'DjangoSession'
  Collection: bookshelf.collection 'DjangoSessions'
