knex = require('knex')
  client: 'sqlite3'
  connection:
    filename: ':memory:'
  useNullAsDefault: yes

bookshelf = require('bookshelf') knex

module.exports.knex = knex

module.exports.bookshelf = bookshelf

module.exports.clean_db = () ->
  knex('auth_user_user_permissions').del()
  .then () -> knex('auth_user_groups').del()
  .then () -> knex('auth_user').del()
  .then () -> knex('auth_group_permissions').del()
  .then () -> knex('auth_group').del()
  .then () -> knex('auth_permission').del()
  .then () -> knex('django_session').del()
  .then () -> knex('django_redirect').del()
  .then () -> knex('django_flatpage_sites').del()
  .then () -> knex('django_flatpage').del()
  .then () -> knex('django_site').del()
  .then () -> knex('django_content_type').del()
