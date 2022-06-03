exports.seed = async (knex, Promise) => {
  await knex('django_flatpage').del();
  await knex('django_flatpage').insert([
    {
      id: 1,
      url: 'https://www.example.com/',
      title: 'Example',
      content: 'page conent',
      template_name: 'example'
    }
  ]);
};
