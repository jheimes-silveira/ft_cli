import 'package:ft_cli/core/utils/bool_utils.dart';
import 'package:ft_cli/core/utils/reserved_words.dart';
import 'package:ft_cli/models/entities/design_pattern/design_pattern.dart';

class UsecaseDesignPattern extends DesignPattern {
  static const String _template = '''
import '{{usecaseNameFileInterface}}.dart';

class {{usecaseNameClass}} implements {{usecaseNameClassInterface}} {
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
      'usecaseNameFile',
      '{{name.snakeCase}}_usecase_impl',
    );
  }

  @override
  String path() {
    return persistValue(
      'usecasePath',
      'domain/usecases',
    );
  }

  @override
  String nameClass() {
    return persistValue(
      'usecaseNameClass',
      '{{name.pascalCase}}UseCaseImpl',
    );
  }

  @override
  String template() {
    return readTemplete(
      'template',
      'usecase.template',
      _template,
      ReservedWords.removeWordsInFile(
        fileString: path(),
      ),
    );
  }

  @override
  String nameDesignPattern() {
    return 'usecase';
  }

  @override
  String extension() {
    return persistValue(
      'usecaseExtension',
      'dart',
    );
  }

  @override
  bool generate() {
    return BoolUtils.parse(persistValue(
      'usecaseGenerate',
      true,
    ));
  }
}
