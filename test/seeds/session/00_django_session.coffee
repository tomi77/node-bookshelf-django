exports.seed = (knex, Promise) ->
  knex('django_session').del()
  .then () ->
    knex('django_session').insert [
      session_key: 'qaz123'
      session_data: 'sessiondata'
      expire_date: new Date()
    ]
