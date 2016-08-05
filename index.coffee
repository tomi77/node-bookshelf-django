module.exports = (bookshelf) ->
  require('./models/django_session') bookshelf
  require('./models/django_site') bookshelf
  require('./models/django_content_type') bookshelf
  require('./models/auth_permission') bookshelf
  require('./models/auth_group') bookshelf
  require('./models/auth_user') bookshelf

  DjangoSession: bookshelf.model 'DjangoSession'
  DjangoSite: bookshelf.model 'DjangoSite'
  DjangoContentType: bookshelf.model 'DjangoContentType'
  AuthPermission: bookshelf.model 'AuthPermission'
  AuthGroup: bookshelf.model 'AuthGroup'
  AuthUser: bookshelf.model 'AuthUser'
