module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('Django.FlatPage')?
    require('./django_site') bookshelf

    bookshelf.model 'Django.FlatPage',
      tableName: 'django_flatpage'

      sites: () -> @belongsToMany 'Django.Sites', 'django_flatpage_sites', 'flatpage_id', 'site_id'

      toString: () -> "#{ @get 'url' } -- #{ @get 'title' }"

  unless bookshelf.collection('Django.FlatPages')?
    bookshelf.collection 'Django.FlatPages',
      model: bookshelf.model 'Django.FlatPage'

  Model: bookshelf.model 'Django.FlatPage'
  Collection: bookshelf.collection 'Django.FlatPages'
