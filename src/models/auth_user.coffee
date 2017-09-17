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

  unless bookshelf.collection('Django.Auth.Users')?
    bookshelf.collection 'Django.Auth.Users',
      model: bookshelf.model 'Django.Auth.User'

  Model: bookshelf.model 'Django.Auth.User'
  Collection: bookshelf.model 'Django.Auth.Users'
