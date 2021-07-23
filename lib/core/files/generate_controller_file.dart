import 'dart:io';

import 'package:js_cli/core/files/configs_file.dart';

class GenerateControllerFile {
  static String templeteNone = r'''
import 'package:mobx/mobx.dart';
part '{{controllerNameFile.snakeCase}}.g.dart';

class {{controllerNameClass.pascalCase}} = _{{controllerNameClass.pascalCase}}Base with _${{controllerNameClass.pascalCase}};

abstract class _{{controllerNameClass.pascalCase}}Base with Store {}

          ''';
  static String templeteFlutterModular = r'''
import 'package:mobx/mobx.dart';
part '{{controllerNameFile.snakeCase}}.g.dart';

class {{controllerNameClass.pascalCase}} = _{{controllerNameClass.pascalCase}}Base with _${{controllerNameClass.pascalCase}};

abstract class _{{controllerNameClass.pascalCase}}Base with Store {}

          ''';

  static String read() {
    final integration = ConfigsFile.getIntegration();
    var path;
    var templete;
    if (integration == 'flutter_modular') {
      path = 'generate_flutter_modular_controller.template';
      templete = templeteFlutterModular;
    } else {
      path = 'generate_none_controller.template';
      templete = templeteNone;
    }

    var existFile = File('.js_cli/template/$path').existsSync();

    if (!existFile) {
      Directory('.js_cli').createSync();
      Directory('.js_cli/template').createSync();
  
      File('.js_cli/template/$path').writeAsStringSync(templete);
    }

    return File('.js_cli/template/$path').readAsStringSync();
  }
}
