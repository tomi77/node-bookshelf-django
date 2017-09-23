Promise = require 'bluebird'

module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('Django.Auth.User')?
    require('./auth_permission') bookshelf
    require('./auth_group') bookshelf

    bookshelf.model 'Django.Auth.User',
      tableName: 'auth_user'

      permissions: () -> @belongsToMany 'Django.Auth.Permissions', 'auth_user_user_permissions', 'user_id', 'permission_id'

      groups: () -> @belongsToMany 'Django.Auth.Groups', 'auth_user_groups', 'user_id', 'group_id'

      getPermissions: () ->
        unless @get 'is_active'
          Promise.resolve []
        else if @get 'is_superuser'
          bookshelf.collection 'Django.Auth.Permissions'
          .forge()
          .fetch withRelated: 'contentType'
        else
          @load ['permissions', 'permissions.contentType', 'groups', 'groups.permissions', 'groups.permissions.contentType']
          .then (user) ->
            Promise.all [
              user.related('groups').getPermissions()
            ,
              user.related('permissions')
            ]
          .then ([groups_permissions, permissions]) ->
            permissions.add groups_permissions.models


  unless bookshelf.collection('Django.Auth.Users')?
    bookshelf.collection 'Django.Auth.Users',
      model: bookshelf.model 'Django.Auth.User'


  Model: bookshelf.model 'Django.Auth.User'
  Collection: bookshelf.collection 'Django.Auth.Users'
