module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('Django.Auth.Permission')?
    require('./django_content_type') bookshelf

    bookshelf.model 'Django.Auth.Permission',
      tableName: 'auth_permission'

      contentType: () -> @belongsTo 'Django.ContentType', 'content_type_id'

      toString: () -> "#{ @related('contentType').get 'app_label' }.#{ @get 'codename' }"


  unless bookshelf.collection('Django.Auth.Permissions')?
    bookshelf.collection 'Django.Auth.Permissions',
      model: bookshelf.model 'Django.Auth.Permission'

      getPermissions: () ->
        @load ['contentType']
        .then () => @mapThen (perm) -> perm.toString()


  Model: bookshelf.model 'Django.Auth.Permission'
  Collection: bookshelf.collection 'Django.Auth.Permissions'
