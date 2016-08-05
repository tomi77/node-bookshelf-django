module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('AuthPermission')?
    require('./django_content_type') bookshelf

    bookshelf.model 'AuthPermission',
      tableName: 'auth_permission'

      contentType: () -> @belongsTo 'DjangoContentType', 'content_type_id'

  bookshelf.model 'AuthPermission'
