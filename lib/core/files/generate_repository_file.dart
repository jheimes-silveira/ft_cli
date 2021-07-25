import 'dart:io';

import 'package:js_cli/core/files/configs_file.dart';
import 'package:js_cli/core/utils/directory_utils.dart';
import 'package:js_cli/core/utils/reserved_words.dart';

class GenerateRepositoryFile {
  static String templateImp = '''
import '../../{{repositoryPathInterface}}/{{repositoryNameFileInterface.snakeCase}}.dart';

class {{repositoryNameClass.pascalCase}} implements {{repositoryNameClassInterface.pascalCase}} {
  @override
  Future<void> call() {
    // TODO: implement call
    throw UnimplementedError();
  }
}
  
  ''';

  static String templateInterface = '''
abstract class {{repositoryNameClassInterface.pascalCase}} {
  Future<void> call();
}
  ''';

  static String readInterface(String name) {
    return _read(
      name,
      'repository_interface.template',
      templateInterface,
      ReservedWords.removeWordsInFile(
        fileString: ConfigsFile.getRepositoryPathInterface(),
      ),
    );
  }

  static String readImp(String name) {
    return _read(
      name,
      'repository.template',
      templateImp,
      ReservedWords.removeWordsInFile(
        fileString: ConfigsFile.getRepositoryPath(),
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
