exports.seed = (knex, Promise) ->
  knex('auth_permission').del()
  .then () ->
    knex('auth_permission').insert [
      id: 1
      name: 'test permission'
      content_type_id: 1
      codename: 'add_test'
    ]
