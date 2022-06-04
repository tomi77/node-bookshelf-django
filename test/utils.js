const knex = require('knex')({
  client: 'sqlite3',
  connection: {
    filename: ':memory:'
  },
  useNullAsDefault: true
});

const bookshelf = require('bookshelf')(knex);

module.exports.knex = knex;

module.exports.bookshelf = bookshelf;

module.exports.clean_db = async () => {
  await knex('auth_user_user_permissions').del();
  await knex('auth_user_groups').del();
  await knex('auth_user').del();
  await knex('auth_group_permissions').del();
  await knex('auth_group').del();
  await knex('auth_permission').del();
  await knex('django_session').del();
  await knex('django_redirect').del();
  await knex('django_flatpage_sites').del();
  await knex('django_flatpage').del();
  await knex('django_site').del();
  await knex('django_content_type').del();
};
