module.exports = (bookshelf) ->
  bookshelf.plugin 'registry'

  unless bookshelf.model('Django.Redirect')?
    require('./django_site') bookshelf

    bookshelf.model 'Django.Redirect',
      tableName: 'django_redirect'

      site: () -> @belongsTo 'Django.Site', 'site_id'

      toString: () -> "#{ @get 'old_path' } --> #{ @get 'new_path' }"

  unless bookshelf.collection('Django.Redirects')?
    bookshelf.collection 'Django.Redirects',
      model: bookshelf.model 'Django.Redirect'

  Model: bookshelf.model 'Django.Redirect'
  Collection: bookshelf.collection 'Django.Redirects'
