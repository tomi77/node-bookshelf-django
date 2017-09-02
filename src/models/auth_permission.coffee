module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('AuthPermission')?
    require('./django_content_type') bookshelf

    bookshelf.model 'AuthPermission',
      tableName: 'auth_permission'

      contentType: () -> @belongsTo 'DjangoContentType', 'content_type_id'

  unless bookshelf.collection('AuthPermissions')?
    bookshelf.collection 'AuthPermissions',
      model: bookshelf.model 'AuthPermission'

  Model: bookshelf.model 'AuthPermission'
  Collection: bookshelf.collection 'AuthPermissions'
