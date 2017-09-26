exports.seed = (knex, Promise) ->
  knex('django_site').del()
  .then () ->
    knex('django_site').insert [
      id: 1
      domain: 'test.example.com'
      name: 'test'
    ]
