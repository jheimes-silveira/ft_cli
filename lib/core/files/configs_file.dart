import 'dart:convert';
import 'dart:io';

class ConfigsFile {
  static String getIntegration() {
    final configs = read();
    if (!configs.containsKey('integration')) {
      configs['integration'] = 'none';
      write(configs);
    }

    return configs['integration'];
  }

  static String getRepositoryPathInterface() {
    final configs = read();
    if (!configs.containsKey('repositoryPathInterface')) {
      configs['repositoryPathInterface'] = 'domain/repositories';
      write(configs);
    }

    return configs['repositoryPathInterface'];
  }

  static String getRepositoryNameFileInterface() {
    final configs = read();
    if (!configs.containsKey('repositoryNameFileInterface')) {
      configs['repositoryNameFileInterface'] = '{{name.snakeCase}}_repository';
      write(configs);
    }

    return configs['repositoryNameFileInterface'];
  }

  static String getRepositoryPath() {
    final configs = read();
    if (!configs.containsKey('repositoryPath')) {
      configs['repositoryPath'] = 'data/repositories';
      write(configs);
    }

    return configs['repositoryPath'];
  }

  static String getRepositoryNameFile() {
    final configs = read();
    if (!configs.containsKey('repositoryNameFile')) {
      configs['repositoryNameFile'] = '{{name.snakeCase}}_imp_repository';
      write(configs);
    }

    return configs['repositoryNameFile'];
  }

  static String getRepositoryNameClassInterface() {
    final configs = read();
    if (!configs.containsKey('repositoryNameClassInterface')) {
      configs['repositoryNameClassInterface'] = '{{name.pascalCase}}Repository';
      write(configs);
    }

    return configs['repositoryNameClassInterface'];
  }

  static String getRepositoryNameClass() {
    final configs = read();
    if (!configs.containsKey('repositoryNameClass')) {
      configs['repositoryNameClass'] = '{{name.pascalCase}}ImpRepository';
      write(configs);
    }

    return configs['repositoryNameClass'];
  }

  static String getDatasourcePathInterface() {
    final configs = read();
    if (!configs.containsKey('datasourcePathInterface')) {
      configs['datasourcePathInterface'] = 'data/datasources';
      write(configs);
    }

    return configs['datasourcePathInterface'];
  }

  static String getDatasourceNameFileInterface() {
    final configs = read();
    if (!configs.containsKey('datasourceNameFileInterface')) {
      configs['datasourceNameFileInterface'] = '{{name.snakeCase}}_datasource';
      write(configs);
    }

    return configs['datasourceNameFileInterface'];
  }

  static String getDatasourcePath() {
    final configs = read();
    if (!configs.containsKey('datasourcePath')) {
      configs['datasourcePath'] = 'external/datasources';
      write(configs);
    }

    return configs['datasourcePath'];
  }

  static String getDatasourceNameFile() {
    final configs = read();
    if (!configs.containsKey('datasourceNameFile')) {
      configs['datasourceNameFile'] = '{{name.snakeCase}}_imp_datasource';
      write(configs);
    }

    return configs['datasourceNameFile'];
  }

  static String getDatasourceNameClassInterface() {
    final configs = read();
    if (!configs.containsKey('datasourceNameClassInterface')) {
      configs['datasourceNameClassInterface'] = '{{name.pascalCase}}Datasource';
      write(configs);
    }

    return configs['datasourceNameClassInterface'];
  }

  static String getDatasourceNameClass() {
    final configs = read();
    if (!configs.containsKey('datasourceNameClass')) {
      configs['datasourceNameClass'] = '{{name.pascalCase}}ImpDatasource';
      write(configs);
    }

    return configs['datasourceNameClass'];
  }

  static String getUsecasePathInterface() {
    final configs = read();
    if (!configs.containsKey('usecasePathInterface')) {
      configs['usecasePathInterface'] = 'domain/usecases';
      write(configs);
    }

    return configs['usecasePathInterface'];
  }

  static String getUsecaseNameFileInterface() {
    final configs = read();
    if (!configs.containsKey('usecaseNameFileInterface')) {
      configs['usecaseNameFileInterface'] = '{{name.snakeCase}}_usecase';
      write(configs);
    }

    return configs['usecaseNameFileInterface'];
  }

  static String getUsecasePath() {
    final configs = read();
    if (!configs.containsKey('usecasePath')) {
      configs['usecasePath'] = 'domain/usecases';
      write(configs);
    }

    return configs['usecasePath'];
  }

  static String getUsecaseNameFile() {
    final configs = read();
    if (!configs.containsKey('usecaseNameFile')) {
      configs['usecaseNameFile'] = '{{name.snakeCase}}_imp_usecase';
      write(configs);
    }

    return configs['usecaseNameFile'];
  }

  static String getUsecaseNameClassInterface() {
    final configs = read();
    if (!configs.containsKey('usecaseNameClassInterface')) {
      configs['usecaseNameClassInterface'] = '{{name.pascalCase}}Usecase';
      write(configs);
    }

    return configs['usecaseNameClassInterface'];
  }

  static String getUsecaseNameClass() {
    final configs = read();
    if (!configs.containsKey('usecaseNameClass')) {
      configs['usecaseNameClass'] = '{{name.pascalCase}}ImpUsecase';
      write(configs);
    }

    return configs['usecaseNameClass'];
  }

  static String getPagePath() {
    final configs = read();
    if (!configs.containsKey('pagePath')) {
      configs['pagePath'] = 'presentation/ui/pages/{{name.snakeCase}}';
      write(configs);
    }

    return configs['pagePath'];
  }

  static String getPageNameFile() {
    final configs = read();
    if (!configs.containsKey('pageNameFile')) {
      configs['pageNameFile'] = '{{name.snakeCase}}_page';
      write(configs);
    }

    return configs['pageNameFile'];
  }

  static String getPageNameClass() {
    final configs = read();
    if (!configs.containsKey('pageNameClass')) {
      configs['pageNameClass'] = '{{name.pascalCase}}Page';
      write(configs);
    }

    return configs['pageNameClass'];
  }

  static String getControllerPath() {
    final configs = read();
    if (!configs.containsKey('controllerPath')) {
      configs['controllerPath'] = 'presentation/ui/pages/{{name.snakeCase}}';
      write(configs);
    }

    return configs['controllerPath'];
  }

  static String getControllerNameFile() {
    final configs = read();
    if (!configs.containsKey('controllerNameFile')) {
      configs['controllerNameFile'] = '{{name.snakeCase}}_controller';
      write(configs);
    }

    return configs['controllerNameFile'];
  }

  static String getControllerNameClass() {
    final configs = read();
    if (!configs.containsKey('controllerNameClass')) {
      configs['controllerNameClass'] = '{{name.pascalCase}}Controller';
      write(configs);
    }

    return configs['controllerNameClass'];
  }

  static String getUsecaseFileInterface() {
    final configs = read();

    if (!configs.containsKey('usecaseFileInterface')) {
      configs['usecaseFileInterface'] = '{{name.snakeCase}}_usecase';
      write(configs);
    }

    return configs['usecaseFileInterface'];
  }

  static String getLayerFolders() {
    final configs = read();

    if (!configs.containsKey('layerFolders')) {
      configs['layerFolders'] = [
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
      write(configs);
    }

    return configs['layerFolders'];
  }

  static void setIntegration(String integration) {
    final configs = read();
    configs['integration'] = integration;
    write(configs);
  }

  static Map<String, dynamic> read() {
    var existFile = File('.js_cli/configs.json').existsSync();

    if (!existFile) {
      Directory('.js_cli').createSync();

      File('.js_cli/configs.json').writeAsStringSync('{}');
    }

    return json.decode(
      File('.js_cli/configs.json').readAsStringSync(),
    );
  }

  static void write(Map<String, dynamic> configs) {
    File('.js_cli/configs.json').writeAsStringSync(
      json.encode(configs),
    );
  }
}
