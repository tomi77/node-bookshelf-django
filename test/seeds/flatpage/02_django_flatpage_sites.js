exports.seed = async (knex, Promise) => {
  await knex('django_flatpage_sites').del();
  await knex('django_flatpage_sites').insert([
    {
      id: 1,
      flatpage_id: 1,
      site_id: 1
    },
    {
      id: 2,
      flatpage_id: 1,
      site_id: 2
    }
  ]);
};
