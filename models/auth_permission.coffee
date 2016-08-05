Bookshelf = require 'bookshelf'

Bookshelf.plugin 'registry'

module.exports = (bookshelf) ->
  require('./django_content_type') bookshelf

  bookshelf.model 'AuthPermission',
    tableName: 'auth_permission'

    contentType: () -> @belongsTo 'DjangoContentType', 'content_type_id'
