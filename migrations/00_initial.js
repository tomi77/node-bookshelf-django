exports.up = async (knex, Promise) => {
  if (!await knex.schema.hasTable('django_content_type')) {
    await knex.schema.createTable('django_content_type', function(table) {
      table.increments().primary();
      table.string('app_label', 100).notNullable();
      table.string('model', 100).notNullable();
      table.unique(['app_label', 'model']);
    })
  }
  if (!await knex.schema.hasTable('django_site')) {
    await knex.schema.createTable('django_site', function(table) {
      table.increments().primary();
      table.string('domain', 100).notNullable();
      table.string('name', 50).notNullable();
    })
  }
  if (!await knex.schema.hasTable('django_flatpage')) {
    await knex.schema.createTable('django_flatpage', function(table) {
      table.increments().primary();
      table.string('url', 100).notNullable();
      table.string('title', 200).notNullable();
      table.text('content').notNullable();
      table.boolean('enable_comments').notNullable().defaultTo(false);
      table.string('template_name', 70).notNullable();
      table.boolean('registration_required').notNullable().defaultTo(false);
      table.index('url');
    })
  }
  if (!await knex.schema.hasTable('django_flatpage_sites')) {
    await knex.schema.createTable('django_flatpage_sites', function(table) {
      table.increments().primary();
      table.integer('flatpage_id').notNullable().references('django_flatpage.id');
      table.integer('site_id').notNullable().references('django_site.id');
      table.unique(['flatpage_id', 'site_id']);
      table.index('flatpage_id');
      table.index('site_id');
    })
  }
  if (!await knex.schema.hasTable('django_redirect')) {
    await knex.schema.createTable('django_redirect', function(table) {
      table.increments().primary();
      table.integer('site_id').notNullable().references('django_site.id');
      table.string('old_path', 200).notNullable();
      table.string('new_path', 200).notNullable();
      table.index('old_path');
      table.unique(['site_id', 'old_path']);
    })
  }
  if (!await knex.schema.hasTable('django_session')) {
    await knex.schema.createTable('django_session', function(table) {
      table.string('session_key', 40).notNullable();
      table.text('session_data').notNullable();
      table.timestamp('expire_date').notNullable();
      table.index('expire_date');
    })
  }
  if (!await knex.schema.hasTable('auth_permission')) {
    await knex.schema.createTable('auth_permission', function(table) {
      table.increments().primary();
      table.string('name', 255).notNullable();
      table.integer('content_type_id').notNullable().references('django_content_type.id');
      table.string('codename', 100).notNullable();
      table.unique(['content_type_id', 'codename']);
      table.index('content_type_id');
    })
  }
  if (!await knex.schema.hasTable('auth_group')) {
    await knex.schema.createTable('auth_group', function(table) {
      table.increments().primary();
      table.string('name', 80).unique().notNullable();
    })
  }
  if (!await knex.schema.hasTable('auth_group_permissions')) {
    await knex.schema.createTable('auth_group_permissions', function(table) {
      table.increments().primary();
      table.integer('group_id').notNullable().references('auth_group.id');
      table.integer('permission_id').notNullable().references('auth_permission.id');
      table.unique(['group_id', 'permission_id']);
      table.index('group_id');
      table.index('permission_id');
    })
  }
  if (!await knex.schema.hasTable('auth_user')) {
    await knex.schema.createTable('auth_user', function(table) {
      table.increments().primary();
      table.string('username', 150).unique().notNullable();
      table.string('first_name', 30).notNullable();
      table.string('last_name', 30).notNullable();
      table.string('email', 254).notNullable();
      table.string('password', 128).notNullable();
      table.boolean('is_staff').notNullable();
      table.boolean('is_active').notNullable();
      table.boolean('is_superuser').notNullable();
      table.timestamp('last_login');
      table.timestamp('date_joined').notNullable();
    })
  }
  if (!await knex.schema.hasTable('auth_user_groups')) {
    await knex.schema.createTable('auth_user_groups', function(table) {
      table.increments().primary();
      table.integer('user_id').notNullable().references('auth_user.id');
      table.integer('group_id').notNullable().references('auth_group.id');
      table.unique(['user_id', 'group_id']);
      table.index('user_id');
      table.index('group_id');
    })
  }
  if (!await knex.schema.hasTable('auth_user_user_permissions')) {
    await knex.schema.createTable('auth_user_user_permissions', function(table) {
      table.increments().primary();
      table.integer('user_id').notNullable().references('auth_user.id');
      table.integer('permission_id').notNullable().references('auth_permission.id');
      table.unique(['user_id', 'permission_id']);
      table.index('user_id');
      table.index('permission_id');
    })
  }
};

exports.down = async (knex, Promise) => {
  await knex.schema.
    dropTableIfExists('auth_user_user_permissions').
    dropTableIfExists('auth_user_groups').
    dropTableIfExists('auth_user').
    dropTableIfExists('auth_group_permissions').
    dropTableIfExists('auth_group').
    dropTableIfExists('auth_permission').
    dropTableIfExists('django_session').
    dropTableIfExists('django_redirect').
    dropTableIfExists('django_flatpage_sites').
    dropTableIfExists('django_flatpage').
    dropTableIfExists('django_site').
    dropTableIfExists('django_content_type');
};
