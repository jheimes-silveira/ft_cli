import 'dart:convert';
import 'dart:io';

abstract class Microfrontend {
  String get component;
  String get prefix;

  Microfrontend();

  String projectNameComplete(String projectName) {
    return '$prefix$divider$component$divider$projectName';
  }

  String get divider {
    return persistValue(
      'divider',
      '_',
    );
  }

  String persistValue(String key, String value) {
    final configs = _readConfigs();
    if (!configs.containsKey(key)) {
      configs[key] = value;
      _writeConfigs(configs);
    }

    return configs[key];
  }

  Map<String, dynamic> _readConfigs() {
    var existFile = File('.js_cli/configs_microfrontend.json').existsSync();

    if (!existFile) {
      Directory('.js_cli').createSync();

      File('.js_cli/configs_microfrontend.json').writeAsStringSync('{}');
    }

    return json.decode(
      File('.js_cli/configs_microfrontend.json').readAsStringSync(),
    );
  }

  void _writeConfigs(Map<String, dynamic> configs) {
    File('.js_cli/configs_microfrontend.json').writeAsStringSync(
      json.encode(configs),
    );
  }
}
