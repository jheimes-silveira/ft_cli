import 'package:js_cli/core/utils/reserved_words.dart';
import 'package:js_cli/app/domain/models/entities/design_pattern.dart';

class UsecaseDesignPattern implements DesignPattern {
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
    return DesignPattern.persistValue(
      'usecaseNameFile',
      '{{name.snakeCase}}_imp_usecase',
    );
  }

  @override
  String path() {
    return DesignPattern.persistValue(
      'usecasePath',
      'domain/usecases',
    );
  }

  @override
  String nameClass() {
    return DesignPattern.persistValue(
      'usecaseNameClass',
      '{{name.pascalCase}}ImpUsecase',
    );
  }

  @override
  String template() {
    return DesignPattern.readTemplete(
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
    return DesignPattern.persistValue(
      'usecaseExtension',
      'dart',
    );
  }
}
