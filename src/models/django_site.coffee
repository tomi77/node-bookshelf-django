module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('DjangoSite')?
    bookshelf.model 'DjangoSite',
      tableName: 'django_site'

  unless bookshelf.collection('DjangoSites')?
    bookshelf.collection 'DjangoSites',
      model: bookshelf.model 'DjangoSite'

  Model: bookshelf.model 'DjangoSite'
  Collection: bookshelf.collection 'DjangoSites'
