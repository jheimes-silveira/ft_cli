
import 'package:js_cli/core/utils/reserved_words.dart';
import 'package:js_cli/app/domain/models/entities/design_pattern.dart';

class RepositoryInterfaceDesignPattern implements DesignPattern {
  static const _template = '''
abstract class {{repositoryNameClassInterface.pascalCase}} {
  Future<void> call();
}
  ''';

  @override
  String nameFile() {
    return DesignPattern.persistValue(
      'repositoryNameFileInterface',
      '{{name.snakeCase}}_repository',
    );
  }

  @override
  String path() {
    return DesignPattern.persistValue(
      'repositoryPathInterface',
      'domain/repositories',
    );
  }

  @override
  String nameClass() {
    return DesignPattern.persistValue(
      'repositoryNameClassInterface',
      '{{name.pascalCase}}Repository',
    );
  }

  @override
  String template() {
    return DesignPattern.readTemplete(
      'repository_interface.template',
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
      'repositoryExtensionInterface',
      'dart',
    );
  }
}
