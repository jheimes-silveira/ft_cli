import 'dart:io';

import 'package:js_cli/core/files/configs_file.dart';
import 'package:js_cli/core/utils/directory_utils.dart';
import 'package:js_cli/core/utils/reserved_words.dart';

class GenerateControllerFile {
  static String template = r'''
import 'package:mobx/mobx.dart';
part '{{controllerNameFile.snakeCase}}.g.dart';

class {{controllerNameClass.pascalCase}} = _{{controllerNameClass.pascalCase}}Base with _${{controllerNameClass.pascalCase}};

abstract class _{{controllerNameClass.pascalCase}}Base with Store {
  @observable
  bool loading = false;

  @action
  void setLoading(bool value) {
    loading = value;
  }
}

          ''';

  static String readImp(String name) {
    return _read(
      name,
      'controller.template',
      template,
      ReservedWords.removeWordsInFile(
        fileString: ConfigsFile.getControllerPath(),
      ),
    );
  }

  static String _read(
    String name,
    String file,
    String template,
    String path,
  ) {
    var root = '.js_cli';

    path = 'template/$path';

    var existFile = File('$root/$path/$file').existsSync();

    if (!existFile) {
      DirectoryUtils.create(root, path);
      File('$root/$path/$file').writeAsStringSync(template);
    }

    return File('$root/$path/$file').readAsStringSync();
  }
}
