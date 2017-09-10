module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('AuthPermission')?
    require('./django_content_type') bookshelf

    bookshelf.model 'AuthPermission',
      tableName: 'auth_permission'

      contentType: () -> @belongsTo 'DjangoContentType', 'content_type_id'

      toString: () -> "#{ @related('contentType').get 'app_label' }.#{ @get 'codename' }"


  unless bookshelf.collection('AuthPermissions')?
    bookshelf.collection 'AuthPermissions',
      model: bookshelf.model 'AuthPermission'

      getPermissions: () ->
        @load ['contentType']
        .then (permissions) -> permissions.map (perm) -> perm.toString()


  Model: bookshelf.model 'AuthPermission'
  Collection: bookshelf.collection 'AuthPermissions'
