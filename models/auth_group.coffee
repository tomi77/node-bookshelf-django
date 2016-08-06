module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('AuthGroup')?
    require('./auth_permission') bookshelf

    bookshelf.model 'AuthGroup',
      tableName: 'auth_group'

      permissions: () -> @belongsToMany 'AuthPermission', 'auth_group_permissions', 'group_id', 'permission_id'

  unless bookshelf.collection('AuthGroups')?
    bookshelf.collection 'AuthGroups',
      model: bookshelf.model 'AuthGroup'

  Model: bookshelf.model 'AuthGroup'
  Collection: bookshelf.model 'AuthGroups'
