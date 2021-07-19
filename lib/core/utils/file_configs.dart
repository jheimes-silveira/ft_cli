import 'dart:convert';
import 'dart:io';

class FileConfigs {
  static String getIntegration() {
    final configs = read();

    if (!configs.containsKey('integration')) {
      configs['integration'] = 'none';
      write(configs);
    }

    return configs['integration'];
  }

  static String getUsecaseFileInterface() {
    final configs = read();

    if (!configs.containsKey('usecaseFileInterface')) {
      configs['usecaseFileInterface'] = '{{name}}_usecase';
      write(configs);
    }

    return configs['usecaseFileInterface'];
  }

  static String getUsecasePath() {
    final configs = read();

    if (!configs.containsKey('usecasePath')) {
      configs['usecasePath'] = 'domain/usecases';
      write(configs);
    }

    return configs['usecasePath'];
  }

  static String getUsecasePathInterface() {
    final configs = read();

    if (!configs.containsKey('usecasePathInterface')) {
      configs['usecasePathInterface'] = 'domain/usecases';
      write(configs);
    }

    return configs['usecasePathInterface'];
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

      File('.js_cli/configs.json').writeAsStringSync(
        '{"integration" : "none"}',
      );
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
