exports.seed = (knex, Promise) ->
  knex('django_content_type').del()
  .then () ->
    knex('django_content_type').insert [
      id: 1
      app_label: 'test'
      model: 'Model'
    ]
