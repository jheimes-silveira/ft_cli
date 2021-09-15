import 'package:js_cli/core/utils/reserved_words.dart';
import 'package:js_cli/app/domain/models/entities/design_pattern.dart';

class UsecaseInterfaceDesignPattern implements DesignPattern {
  static const _template = '''
abstract class {{usecaseNameClassInterface.pascalCase}} {
  Future<void> call();
}
  ''';

  @override
  String nameFile() {
    return DesignPattern.persistValue(
      'usecaseNameFileInterface',
      '{{name.snakeCase}}_usecase',
    );
  }

  @override
  String path() {
    return DesignPattern.persistValue(
      'usecasePathInterface',
      'domain/usecases',
    );
  }

  @override
  String nameClass() {
    return DesignPattern.persistValue(
      'usecaseNameClassInterface',
      '{{name.pascalCase}}Usecase',
    );
  }

  @override
  String template() {
    return DesignPattern.readTemplete(
      'usecase_interface.template',
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
      'usecaseExtensionInterface',
      'dart',
    );
  }
}
