import 'package:js_cli/core/utils/reserved_words.dart';
import 'package:js_cli/models/entities/design_pattern/design_pattern.dart';

class RepositoryDesignPattern extends DesignPattern {
  static const String _template = '''
import '../../{{repositoryPathInterface}}/{{repositoryNameFileInterface.snakeCase}}.dart';

class {{repositoryNameClass.pascalCase}} implements {{repositoryNameClassInterface.pascalCase}} {
  @override
  Future<void> call() {
    // TODO: implement call
    throw UnimplementedError();
  }
}
  
  ''';

  @override
  String nameFile() {
    return persistValue(
      'repositoryNameFile',
      '{{name.snakeCase}}_imp_repository',
    );
  }

  @override
  String path() {
    return persistValue(
      'repositoryPath',
      'data/repositories',
    );
  }

  @override
  String nameClass() {
    return persistValue(
      'repositoryNameClass',
      '{{name.pascalCase}}ImpRepository',
    );
  }

  @override
  String template() {
    return readTemplete(
      'repository.template',
      _template,
      ReservedWords.removeWordsInFile(
        fileString: path(),
      ),
    );
  }

  @override
  String nameDesignPattern() {
    return 'repository';
  }

  @override
  String extension() {
    return persistValue(
      'repositoryExtension',
      'dart',
    );
  }
}
