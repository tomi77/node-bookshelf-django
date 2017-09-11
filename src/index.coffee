module.exports = (bookshelf) ->
  require('./models/django_session') bookshelf
  require('./models/django_site') bookshelf
  require('./models/django_content_type') bookshelf
  require('./models/auth_permission') bookshelf
  require('./models/auth_group') bookshelf
  require('./models/auth_user') bookshelf

  Session: bookshelf.model 'Django.Session'
  Sessions: bookshelf.collection 'Django.Sessions'
  Site: bookshelf.model 'Django.Site'
  Sites: bookshelf.collection 'Django.Sites'
  ContentType: bookshelf.model 'Django.ContentType'
  ContentTypes: bookshelf.collection 'Django.ContentTypes'

  Auth:
    Permission: bookshelf.model 'Django.Auth.Permission'
    Permissions: bookshelf.collection 'Django.Auth.Permissions'
    Group: bookshelf.model 'Django.Auth.Group'
    Groups: bookshelf.collection 'Django.Auth.Groups'
    User: bookshelf.model 'Django.Auth.User'
    Users: bookshelf.collection 'Django.Auth.Users'
