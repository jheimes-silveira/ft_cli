import 'package:js_cli/core/utils/reserved_words.dart';
import 'package:js_cli/models/entities/design_pattern/design_pattern.dart';

class UsecaseDesignPattern extends DesignPattern {
  static const String _template = '''
import '{{usecaseNameFileInterface.snakeCase}}.dart';

class {{usecaseNameClass.pascalCase}} implements {{usecaseNameClassInterface.pascalCase}} {
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
      '{{name.snakeCase}}_imp_usecase',
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
      '{{name.pascalCase}}ImpUsecase',
    );
  }

  @override
  String template() {
    return readTemplete(
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
}
