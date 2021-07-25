import 'dart:io';

import 'package:js_cli/core/utils/directory_utils.dart';
import 'package:js_cli/core/utils/reserved_words.dart';

import 'configs_file.dart';

class GenerateDatasourceFile {
  static String templateImp = '''
import '../../{{datasourcePathInterface}}/{{datasourceNameFileInterface.snakeCase}}.dart';

class {{datasourceNameClass.pascalCase}} implements {{datasourceNameClassInterface.pascalCase}} {
  @override
  Future<void> call() {
    // TODO: implement call
    throw UnimplementedError();
  }
}
  
  ''';

  static String templateInterface = '''
abstract class {{datasourceNameClassInterface.pascalCase}} {
  Future<void> call();
}
  ''';

  static String readInterface(String name) {
    return _read(
      name,
      'datasource_interface.template',
      templateInterface,
      ReservedWords.removeWordsInFile(
        fileString: ConfigsFile.getDatasourcePathInterface(),
      ),
    );
  }

  static String readImp(String name) {
    return _read(
      name,
      'datasource.template',
      templateImp,
      ReservedWords.removeWordsInFile(
        fileString: ConfigsFile.getDatasourcePath(),
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
