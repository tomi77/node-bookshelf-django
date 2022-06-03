exports.seed = async (knex, Promise) => {
  await knex('auth_group_permissions').del();
  await knex('auth_group_permissions').insert([
    {
      id: 1,
      group_id: 1,
      permission_id: 1
    },
    {
      id: 2,
      group_id: 1,
      permission_id: 2
    },
    {
      id: 3,
      group_id: 1,
      permission_id: 3
    },
    {
      id: 4,
      group_id: 2,
      permission_id: 3
    },
    {
      id: 5,
      group_id: 2,
      permission_id: 4
    },
    {
      id: 6,
      group_id: 3,
      permission_id: 5
    },
    {
      id: 7,
      group_id: 3,
      permission_id: 6
    }
  ]);
};
