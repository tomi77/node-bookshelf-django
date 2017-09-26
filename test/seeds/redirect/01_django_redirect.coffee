exports.seed = (knex, Promise) ->
  knex('django_redirect').del()
  .then () ->
    knex('django_redirect').insert [
      id: 1
      site_id: 1
      old_path: '/old'
      new_path: '/new'
    ]
