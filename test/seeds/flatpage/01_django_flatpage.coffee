exports.seed = (knex, Promise) ->
  knex('django_flatpage').del()
  .then () ->
    knex('django_flatpage').insert [
      id: 1
      url: 'https://www.example.com/'
      title: 'Example'
      content: 'page conent'
      template_name: 'example'
    ]
