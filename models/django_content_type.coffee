Bookshelf = require 'bookshelf'

Bookshelf.plugin 'registry'

module.exports = (bookshelf) ->
  bookshelf.model 'DjangoContentType',
    tableName: 'django_content_type'
