exports.seed = (knex, Promise) ->
  knex('auth_group').del()
  .then () ->
    knex('auth_group').insert [
      id: 1
      name: 'group 1'
    ,
      id: 2
      name: 'group 2'
    ]
