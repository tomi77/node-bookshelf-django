exports.seed = async (knex, Promise) => {
  await knex('django_content_type').del();
  await knex('django_content_type').insert([
    {
      id: 1,
      app_label: 'test',
      model: 'Model'
    },
    {
      id: 2,
      app_label: 'test2',
      model: 'Model2'
    }
  ]);
};
