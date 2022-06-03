exports.seed = async (knex, Promise) => {
  await knex('auth_permission').del();
  await knex('auth_permission').insert([
    {
      id: 1,
      name: 'can add test',
      content_type_id: 1,
      codename: 'add_test'
    },
    {
      id: 2,
      name: 'can delete test',
      content_type_id: 1,
      codename: 'delete_test'
    },
    {
      id: 3,
      name: 'can change test',
      content_type_id: 1,
      codename: 'change_test'
    },
    {
      id: 4,
      name: 'can add test 2',
      content_type_id: 2,
      codename: 'add_test2'
    },
    {
      id: 5,
      name: 'can delete test 2',
      content_type_id: 2,
      codename: 'delete_test2'
    },
    {
      id: 6,
      name: 'can change test 2',
      content_type_id: 2,
      codename: 'change_test2'
    }
  ]);
};
