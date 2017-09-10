exports.seed = (knex, Promise) ->
  knex('auth_permission').del()
  .then () ->
    knex('auth_permission').insert [
      id: 1
      name: 'can add test'
      content_type_id: 1
      codename: 'add_test'
    ,
      id: 2
      name: 'can delete test'
      content_type_id: 1
      codename: 'delete_test'
    ,
      id: 3
      name: 'can change test'
      content_type_id: 1
      codename: 'change_test'
    ]
