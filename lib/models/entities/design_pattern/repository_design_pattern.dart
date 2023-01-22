import 'package:ft_cli/core/utils/bool_utils.dart';
import 'package:ft_cli/core/utils/reserved_words.dart';
import 'package:ft_cli/models/entities/design_pattern/design_pattern.dart';

class RepositoryDesignPattern extends DesignPattern {
  static const String _template = '''
import '../../{{repositoryPathInterface}}/{{repositoryNameFileInterface}}.{{repositoryExtensionInterface}}';

class {{repositoryNameClass}} implements {{repositoryNameClassInterface}} {
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
      '{{name.snakeCase}}_repository_impl',
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
      '{{name.pascalCase}}RepositoryImpl',
    );
  }

  @override
  String template() {
    return readTemplete(
      'template',
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

  @override
  bool generate() {
    return BoolUtils.parse(persistValue(
      'repositoryGenerate',
      true,
    ));
  }
}
