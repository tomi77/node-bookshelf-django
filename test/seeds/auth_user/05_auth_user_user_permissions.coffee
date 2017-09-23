exports.seed = (knex, Promise) ->
  knex('auth_user_user_permissions').del()
  .then () ->
    knex('auth_user_user_permissions').insert [
      id: 1
      user_id: 3
      permission_id: 6
    ,
      id: 2
      user_id: 3
      permission_id: 1
    ]
