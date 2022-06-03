exports.seed = async (knex, Promise) => {
  await knex('django_redirect').del();
  await knex('django_redirect').insert([
    {
      id: 1,
      site_id: 1,
      old_path: '/old',
      new_path: '/new'
    }
  ]);
};
