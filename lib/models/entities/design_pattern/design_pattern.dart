import 'dart:convert';
import 'dart:io';

import 'package:js_cli/core/utils/directory_utils.dart';

abstract class DesignPattern {
  String extension();
  String nameClass();
  String nameFile();
  String path();
  String template();
  String nameDesignPattern();

  String readTemplete(
    String group,
    String file,
    String template,
    String path,
  ) {
    var root = '.js_cli';

    path = '$group/$path';

    var existFile = File('$root/$path/$file').existsSync();

    if (!existFile) {
      DirectoryUtils.create(root + '/' + path);
      File('$root/$path/$file').writeAsStringSync(template);
    }

    return File('$root/$path/$file').readAsStringSync();
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
    var existFile = File('.js_cli/configs.json').existsSync();

    if (!existFile) {
      Directory('.js_cli').createSync();

      File('.js_cli/configs.json').writeAsStringSync('{}');
    }

    return json.decode(
      File('.js_cli/configs.json').readAsStringSync(),
    );
  }

  void _writeConfigs(Map<String, dynamic> configs) {
    File('.js_cli/configs.json').writeAsStringSync(
      json.encode(configs),
    );
  }
}
