Bookshelf = require 'bookshelf'

Bookshelf.plugin 'registry'

module.exports = (bookshelf) ->
  require('./auth_permission') bookshelf
  require('./auth_group') bookshelf

  bookshelf.model 'AuthUser',
    tableName: 'auth_user'

    permissions: () -> @belongsToMany 'AuthPermission', 'auth_user_user_permissions', 'user_id', 'permission_id'

    groups: () -> @belongsToMany 'AuthGroup', 'auth_user_groups', 'user_id', 'group_id'
