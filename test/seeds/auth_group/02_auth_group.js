exports.seed = async (knex, Promise) => {
  await knex('auth_group').del();
  await knex('auth_group').insert([
    {
      id: 1,
      name: 'group 1'
    },
    {
      id: 2,
      name: 'group 2'
    }
  ]);
};
