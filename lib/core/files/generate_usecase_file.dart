import 'dart:io';

import 'package:js_cli/core/utils/directory_utils.dart';
import 'package:js_cli/core/utils/reserved_words.dart';

import 'configs_file.dart';

class GenerateUsecaseFile {
  static String templateImp = '''
import '{{usecaseNameFileInterface.snakeCase}}.dart';

class {{usecaseNameClass.pascalCase}} implements {{usecaseNameClassInterface.pascalCase}} {
  @override
  Future<void> call() {
    // TODO: implement call
    throw UnimplementedError();
  }
}
  ''';

  static String templateInterface = '''
abstract class {{usecaseNameClassInterface.pascalCase}} {
  Future<void> call();
}
  ''';

  static String readInterface(String name) {
    return _read(
      name,
      'usecase_interface.template',
      templateInterface,
      ReservedWords.removeWordsInFile(
        fileString: ConfigsFile.getUsecasePathInterface(),
      ),
    );
  }

  static String readImp(String name) {
    return _read(
      name,
      'usecase.template',
      templateImp,
      ReservedWords.removeWordsInFile(
        fileString: ConfigsFile.getUsecasePath(),
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
