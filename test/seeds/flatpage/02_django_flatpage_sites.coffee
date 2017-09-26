exports.seed = (knex, Promise) ->
  knex('django_flatpage_sites').del()
  .then () ->
    knex('django_flatpage_sites').insert [
      id: 1
      flatpage_id: 1
      site_id: 1
    ,
      id: 2
      flatpage_id: 1
      site_id: 2
    ]
