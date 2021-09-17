import 'package:js_cli/core/utils/reserved_words.dart';
import 'package:js_cli/models/entities/design_pattern/design_pattern.dart';

class DtoDesignPattern extends DesignPattern {
  static const String _template = '''
class {{dtoNameClass.pascalCase}} {
  {{dtoNameClass.pascalCase}}();
}
  ''';
  @override
  String nameFile() {
    return persistValue(
      'dtoNameFile',
      '{{name.snakeCase}}_dto',
    );
  }

  @override
  String path() {
    return persistValue(
      'dtoPath',
      'domain/models/dtos',
    );
  }

  @override
  String nameClass() {
    return persistValue(
      'dtoNameClass',
      '{{name.pascalCase}}Dto',
    );
  }

  @override
  String template() {
    return readTemplete(
      'template',
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
    return persistValue(
      'dtoExtension',
      'dart',
    );
  }
}
