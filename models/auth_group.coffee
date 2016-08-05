Bookshelf = require 'bookshelf'

Bookshelf.plugin 'registry'

module.exports = (bookshelf) ->
  require('./auth_permission') bookshelf

  bookshelf.model 'AuthGroup',
    tableName: 'auth_group'

    permissions: () -> @belongsToMany 'AuthPermission', 'auth_group_permissions', 'group_id', 'permission_id'
