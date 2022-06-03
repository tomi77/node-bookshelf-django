exports.seed = async (knex, Promise) => {
  await knex('django_session').del();
  await knex('django_session').insert([
    {
      session_key: 'qaz123',
      session_data: 'sessiondata',
      expire_date: new Date()
    }
  ]);
};
