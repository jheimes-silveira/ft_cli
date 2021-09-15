import 'package:js_cli/core/utils/reserved_words.dart';
import 'package:js_cli/app/domain/models/entities/design_pattern.dart';

class DtoDesignPattern implements DesignPattern {
  static const String _template = '''
class {{dtoNameClass.pascalCase}} {
  {{dtoNameClass.pascalCase}}();
}
  ''';
  @override
  String nameFile() {
    return DesignPattern.persistValue(
      'dtoNameFile',
      '{{name.snakeCase}}_dto',
    );
  }

  @override
  String path() {
    return DesignPattern.persistValue(
      'dtoPath',
      'domain/models/dtos',
    );
  }

  @override
  String nameClass() {
    return DesignPattern.persistValue(
      'dtoNameClass',
      '{{name.pascalCase}}Dto',
    );
  }

  @override
  String template() {
    return DesignPattern.readTemplete(
      'dto.template',
      _template,
      ReservedWords.removeWordsInFile(
        fileString: path(),
      ),
    );
  }

  @override
  String nameDesignPattern() {
    return 'dto';
  }

  @override
  String extension() {
    return DesignPattern.persistValue(
      'dtoExtension',
      'dart',
    );
  }
}
