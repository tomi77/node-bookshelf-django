exports.seed = (knex, Promise) ->
  knex('django_site').del()
  .then () ->
    knex('django_site').insert [
      id: 1
      domain: 'www.example.com'
      name: 'test'
    ,
      id: 2
      domain: 'www2.example.com'
      name: 'test 2'
    ]
