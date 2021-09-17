import 'package:js_cli/core/utils/reserved_words.dart';
import 'package:js_cli/models/entities/design_pattern/design_pattern.dart';

class RepositoryInterfaceDesignPattern extends DesignPattern {
  static const _template = '''
abstract class {{repositoryNameClassInterface.pascalCase}} {
  Future<void> call();
}
  ''';

  @override
  String nameFile() {
    return persistValue(
      'repositoryNameFileInterface',
      '{{name.snakeCase}}_repository',
    );
  }

  @override
  String path() {
    return persistValue(
      'repositoryPathInterface',
      'domain/repositories',
    );
  }

  @override
  String nameClass() {
    return persistValue(
      'repositoryNameClassInterface',
      '{{name.pascalCase}}Repository',
    );
  }

  @override
  String template() {
    return readTemplete(
      'template',
      'repository_interface.template',
      _template,
      ReservedWords.removeWordsInFile(
        fileString: path(),
      ),
    );
  }

  @override
  String nameDesignPattern() {
    return 'repository_interface';
  }

  @override
  String extension() {
    return persistValue(
      'repositoryExtensionInterface',
      'dart',
    );
  }
}
