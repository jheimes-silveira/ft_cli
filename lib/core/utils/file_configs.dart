import 'dart:convert';
import 'dart:io';

class FileConfigs {
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
