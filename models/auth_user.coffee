module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('AuthUser')?
    require('./auth_permission') bookshelf
    require('./auth_group') bookshelf

    bookshelf.model 'AuthUser',
      tableName: 'auth_user'

      permissions: () -> @belongsToMany 'AuthPermission', 'auth_user_user_permissions', 'user_id', 'permission_id'

      groups: () -> @belongsToMany 'AuthGroup', 'auth_user_groups', 'user_id', 'group_id'

  unless bookshelf.collection('AuthUsers')?
    bookshelf.collection 'AuthUsers',
      model: bookshelf.model 'AuthUser'

  Model: bookshelf.model 'AuthUser'
  Collection: bookshelf.model 'AuthUsers'
