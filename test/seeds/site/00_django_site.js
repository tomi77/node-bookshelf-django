exports.seed = async (knex, Promise) => {
  await knex('django_site').del();
  await knex('django_site').insert([
    {
      id: 1,
      domain: 'test.example.com',
      name: 'test'
    }
  ]);
};
