module.exports = (knex) ->
  contenttypes: [
    () -> knex.schema.createTableIfNotExists 'django_content_type', (table) ->
      table.increments()
      table.string 'name'
      table.string 'app_label'
      table.string 'model'
      return
  ]

  sessions: [
    () -> knex.schema.createTableIfNotExists 'django_session', (table) ->
      table.string 'session_key'
      table.primary 'session_key'
      table.text 'session_data'
      table.dateTime 'expire_date'
      return
  ]

  sites: [
    () -> knex.schema.createTableIfNotExists 'django_site', (table) ->
      table.increments()
      table.string 'domain'
      table.string 'name'
      return
  ]

  auth: [
    () -> knex.schema.createTableIfNotExists 'auth_permission', (table) ->
      table.increments()
      table.string 'name'
      table.integer 'content_type_id'
      table.foreign('content_type_id').references('django_content_type.id')
      table.string 'codename'
      return

    () -> knex.schema.createTableIfNotExists 'auth_group', (table) ->
      table.increments()
      table.string 'name'
      return

    () -> knex.schema.createTableIfNotExists 'auth_group_permissions', (table) ->
      table.increments()
      table.integer 'group_id'
      table.foreign('group_id').references('auth_group.id')
      table.integer 'permission_id'
      table.foreign('permission_id').references('auth_permission.id')
      return

    () -> knex.schema.createTableIfNotExists 'auth_user', (table) ->
      table.increments()
      table.string('username').unique()
      table.string 'first_name'
      table.string 'last_name'
      table.string 'email'
      table.string 'password'
      table.boolean 'is_staff'
      table.boolean 'is_active'
      table.boolean 'is_superuser'
      table.dateTime 'last_login'
      table.dateTime 'date_joined'
      return

    () -> knex.schema.createTableIfNotExists 'auth_user_groups', (table) ->
      table.increments()
      table.integer 'user_id'
      table.foreign('user_id').references('auth_user.id')
      table.integer 'group_id'
      table.foreign('group_id').references('auth_group.id')
      return

    () -> knex.schema.createTableIfNotExists 'auth_user_user_permissions', (table) ->
      table.increments()
      table.integer 'user_id'
      table.foreign('user_id').references('auth_user.id')
      table.integer 'permission_id'
      table.foreign('permission_id').references('auth_permission.id')
      return
  ]
