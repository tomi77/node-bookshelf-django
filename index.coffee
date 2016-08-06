module.exports = (bookshelf) ->
  require('./models/django_session') bookshelf
  require('./models/django_site') bookshelf
  require('./models/django_content_type') bookshelf
  require('./models/auth_permission') bookshelf
  require('./models/auth_group') bookshelf
  require('./models/auth_user') bookshelf

  DjangoSession: bookshelf.model 'DjangoSession'
  DjangoSessions: bookshelf.collection 'DjangoSessions'
  DjangoSite: bookshelf.model 'DjangoSite'
  DjangoSites: bookshelf.collection 'DjangoSites'
  DjangoContentType: bookshelf.model 'DjangoContentType'
  DjangoContentTypes: bookshelf.collection 'DjangoContentTypes'
  AuthPermission: bookshelf.model 'AuthPermission'
  AuthPermissions: bookshelf.collection 'AuthPermissions'
  AuthGroup: bookshelf.model 'AuthGroup'
  AuthGroups: bookshelf.collection 'AuthGroups'
  AuthUser: bookshelf.model 'AuthUser'
  AuthUsers: bookshelf.collection 'AuthUsers'
