Bookshelf = require 'bookshelf'

Bookshelf.plugin 'registry'

module.exports = (bookshelf) ->
  bookshelf.model 'DjangoSite',
    tableName: 'django_site'
