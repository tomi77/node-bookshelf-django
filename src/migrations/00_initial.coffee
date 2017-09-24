exports.up = (knex, Promise) ->
  knex.schema
  .createTableIfNotExists 'django_content_type', (table) ->
    table.increments().primary()
    table.string('app_label', 100).notNullable()
    table.string('model', 100).notNullable()
    table.unique(['app_label', 'model'])
    return
  .createTableIfNotExists 'django_site', (table) ->
    table.increments().primary()
    table.string('domain', 100).notNullable()
    table.string('name', 50).notNullable()
    return
  .createTableIfNotExists 'django_flatpage', (table) ->
    table.increments().primary()
    table.string('url', 100).notNullable()
    table.string('title', 200).notNullable()
    table.text('content').notNullable()
    table.boolean('enable_comments').notNullable().defaultTo(no)
    table.string('template_name', 70).notNullable()
    table.boolean('registration_required').notNullable().defaultTo(no)
    table.index('url')
    return
  .createTableIfNotExists 'django_flatpage_sites', (table) ->
    table.increments().primary()
    table.integer('flatpage_id').notNullable().references('django_flatpage.id')
    table.integer('site_id').notNullable().references('django_site.id')
    table.unique(['flatpage_id', 'site_id'])
    table.index('flatpage_id')
    table.index('site_id')
    return
  .createTableIfNotExists 'django_redirect', (table) ->
    table.increments().primary()
    table.integer('site_id').notNullable().references('django_site.id')
    table.string('old_path', 200).notNullable()
    table.string('new_path', 200).notNullable()
    table.index('old_path')
    table.unique(['site_id', 'old_path'])
    return
  .createTableIfNotExists 'django_session', (table) ->
    table.string('session_key', 40).notNullable()
    table.text('session_data').notNullable()
    table.timestamp('expire_date').notNullable()
    table.index('expire_date')
    return
  .createTableIfNotExists 'auth_permission', (table) ->
    table.increments().primary()
    table.string('name', 255).notNullable()
    table.integer('content_type_id').notNullable().references('django_content_type.id')
    table.string('codename', 100).notNullable()
    table.unique(['content_type_id', 'codename'])
    table.index('content_type_id')
    return
  .createTableIfNotExists 'auth_group', (table) ->
    table.increments().primary()
    table.string('name', 80).unique().notNullable()
    return
  .createTableIfNotExists 'auth_group_permissions', (table) ->
    table.increments().primary()
    table.integer('group_id').notNullable().references('auth_group.id')
    table.integer('permission_id').notNullable().references('auth_permission.id')
    table.unique(['group_id', 'permission_id'])
    table.index('group_id')
    table.index('permission_id')
    return
  .createTableIfNotExists 'auth_user', (table) ->
    table.increments().primary()
    table.string('username', 150).unique().notNullable()
    table.string('first_name', 30).notNullable()
    table.string('last_name', 30).notNullable()
    table.string('email', 254).notNullable()
    table.string('password', 128).notNullable()
    table.boolean('is_staff').notNullable()
    table.boolean('is_active').notNullable()
    table.boolean('is_superuser').notNullable()
    table.timestamp('last_login')
    table.timestamp('date_joined').notNullable()
    return
  .createTableIfNotExists 'auth_user_groups', (table) ->
    table.increments().primary()
    table.integer('user_id').notNullable().references('auth_user.id')
    table.integer('group_id').notNullable().references('auth_group.id')
    table.unique(['user_id', 'group_id'])
    table.index('user_id')
    table.index('group_id')
    return
  .createTableIfNotExists 'auth_user_user_permissions', (table) ->
    table.increments().primary()
    table.integer('user_id').notNullable().references('auth_user.id')
    table.integer('permission_id').notNullable().references('auth_permission.id')
    table.unique(['user_id', 'permission_id'])
    table.index('user_id')
    table.index('permission_id')
    return


exports.down = (knex, Promise) ->
  knex.schema
  .dropTableIfExists('auth_user_user_permissions')
  .dropTableIfExists('auth_user_groups')
  .dropTableIfExists('auth_user')
  .dropTableIfExists('auth_group_permissions')
  .dropTableIfExists('auth_group')
  .dropTableIfExists('auth_permission')
  .dropTableIfExists('django_session')
  .dropTableIfExists('django_redirect')
  .dropTableIfExists('django_flatpage_sites')
  .dropTableIfExists('django_flatpage')
  .dropTableIfExists('django_site')
  .dropTableIfExists('django_content_type')
