module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('AuthGroup')?
    require('./auth_permission') bookshelf

    bookshelf.model 'AuthGroup',
      tableName: 'auth_group'

      permissions: () -> @belongsToMany 'AuthPermission', 'auth_group_permissions', 'group_id', 'permission_id'

  bookshelf.model 'AuthGroup'
