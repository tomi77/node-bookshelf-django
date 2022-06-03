exports.seed = async (knex, Promise) => {
  await knex('auth_permission').del();
  await knex('auth_permission').insert([
    {
      id: 1,
      name: 'test permission',
      content_type_id: 1,
      codename: 'add_test'
    }
  ]);
};
