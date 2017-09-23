Promise = require 'bluebird'
_ = require 'lodash'

module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('Django.Auth.Group')?
    require('./auth_permission') bookshelf

    bookshelf.model 'Django.Auth.Group',
      tableName: 'auth_group'

      permissions: () -> @belongsToMany 'Django.Auth.Permissions', 'auth_group_permissions', 'group_id', 'permission_id'

      getPermissions: () ->
        @load ['permissions', 'permissions.contentType']
        .then (group) -> group.related('permissions')


  unless bookshelf.collection('Django.Auth.Groups')?
    bookshelf.collection 'Django.Auth.Groups',
      model: bookshelf.model 'Django.Auth.Group'

      getPermissions: () ->
        @mapThen (group) -> group.getPermissions()
        .then (x) ->
          _.reduce x, (memo, y) ->
            memo.concat y.models
          , []
        .then (permissions) -> _.uniqBy permissions, (permission) -> permission.get 'id'
        .then (permissions) -> bookshelf.collection('Django.Auth.Permissions').forge(permissions)


  Model: bookshelf.model 'Django.Auth.Group'
  Collection: bookshelf.collection 'Django.Auth.Groups'
