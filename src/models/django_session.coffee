module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('Django.Session')?
    bookshelf.model 'Django.Session',
      tableName: 'django_session'

      toString: () -> "#{ @get 'session_key' }"

  unless bookshelf.collection('Django.Sessions')?
    bookshelf.collection 'Django.Sessions',
      model: bookshelf.model 'Django.Session'

  Model: bookshelf.model 'Django.Session'
  Collection: bookshelf.collection 'Django.Sessions'
