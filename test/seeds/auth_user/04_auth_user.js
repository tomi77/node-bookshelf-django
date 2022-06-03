exports.seed = async (knex, Promise) => {
  await knex('auth_user').del();
  await knex('auth_user').insert([
    {
      id: 1,
      username: 'user1',
      first_name: '',
      last_name: '',
      email: '',
      password: '',
      is_staff: false,
      is_active: false,
      is_superuser: false,
      date_joined: new Date()
    },
    {
      id: 2,
      username: 'user2',
      first_name: '',
      last_name: '',
      email: '',
      password: '',
      is_staff: false,
      is_active: true,
      is_superuser: true,
      date_joined: new Date()
    },
    {
      id: 3,
      username: 'user3',
      first_name: '',
      last_name: '',
      email: '',
      password: '',
      is_staff: false,
      is_active: true,
      is_superuser: false,
      date_joined: new Date()
    }
  ]);
};
