module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('DjangoSite')?
    bookshelf.model 'DjangoSite',
      tableName: 'django_site'

  bookshelf.model 'DjangoSite'
