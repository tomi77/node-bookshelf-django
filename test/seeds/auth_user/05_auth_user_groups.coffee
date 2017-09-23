exports.seed = (knex, Promise) ->
  knex('auth_user_groups').del()
  .then () ->
    knex('auth_user_groups').insert [
      id: 1
      user_id: 3
      group_id: 1
    ]
