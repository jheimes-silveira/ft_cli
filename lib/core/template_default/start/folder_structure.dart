class FolderStruture {
  final template = [
    {
      'data': [
        'datasources',
        'repositories',
      ],
    },
    {
      'domain': [
        {
          'models': [
            'dtos',
            'entities',
          ],
        },
        'repositories',
        'usecases',
      ],
    },
    {
      'external': [],
    },
    'presentation',
  ];
}
