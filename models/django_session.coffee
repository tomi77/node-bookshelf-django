Bookshelf = require 'bookshelf'

Bookshelf.plugin 'registry'

module.exports = (bookshelf) ->
  bookshelf.model 'DjangoSession',
    tableName: 'django_session'
