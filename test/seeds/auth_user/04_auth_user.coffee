exports.seed = (knex, Promise) ->
  knex('auth_user').del()
  .then () ->
    knex('auth_user').insert [
      id: 1
      username: 'user1'
      first_name: ''
      last_name: ''
      email: ''
      password: ''
      is_staff: no
      is_active: no
      is_superuser: no
      date_joined: new Date()
    ,
      id: 2
      username: 'user2'
      first_name: ''
      last_name: ''
      email: ''
      password: ''
      is_staff: no
      is_active: yes
      is_superuser: yes
      date_joined: new Date()
    ,
      id: 3
      username: 'user3'
      first_name: ''
      last_name: ''
      email: ''
      password: ''
      is_staff: no
      is_active: yes
      is_superuser: no
      date_joined: new Date()
    ]
