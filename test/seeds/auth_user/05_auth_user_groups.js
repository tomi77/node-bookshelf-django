exports.seed = async (knex, Promise) => {
  await knex('auth_user_groups').del();
  await knex('auth_user_groups').insert([
    {
      id: 1,
      user_id: 3,
      group_id: 1
    }
  ]);
};
