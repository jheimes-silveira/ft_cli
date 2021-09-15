import 'package:js_cli/core/utils/reserved_words.dart';
import 'package:js_cli/app/domain/models/entities/design_pattern.dart';

class RepositoryDesignPattern implements DesignPattern {
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
    return DesignPattern.persistValue(
      'repositoryNameFile',
      '{{name.snakeCase}}_imp_repository',
    );
  }

  @override
  String path() {
    return DesignPattern.persistValue(
      'repositoryPath',
      'data/repositories',
    );
  }

  @override
  String nameClass() {
    return DesignPattern.persistValue(
      'repositoryNameClass',
      '{{name.pascalCase}}ImpRepository',
    );
  }

  @override
  String template() {
    return DesignPattern.readTemplete(
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
    return DesignPattern.persistValue(
      'repositoryExtension',
      'dart',
    );
  }
}
