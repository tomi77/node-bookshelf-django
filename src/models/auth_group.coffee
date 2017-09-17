module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('Django.Auth.Group')?
    require('./auth_permission') bookshelf

    bookshelf.model 'Django.Auth.Group',
      tableName: 'auth_group'

      permissions: () -> @belongsToMany 'Django.Auth.Permissions', 'auth_group_permissions', 'group_id', 'permission_id'

      getPermissions: () ->
        @load ['permissions']
        .then (group) ->
          group.related('permissions').getPermissions()


  unless bookshelf.collection('Django.Auth.Groups')?
    bookshelf.collection 'Django.Auth.Groups',
      model: bookshelf.model 'Django.Auth.Group'


  Model: bookshelf.model 'Django.Auth.Group'
  Collection: bookshelf.collection 'Django.Auth.Groups'
