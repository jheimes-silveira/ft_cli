import 'package:js_cli/core/utils/reserved_words.dart';
import 'package:js_cli/app/domain/models/entities/design_pattern.dart';

class EntityDesignPattern implements DesignPattern {
  static const String _template = '''
class {{entityNameClass.pascalCase}} {
  {{entityNameClass.pascalCase}}();
}
  ''';
  @override
  String nameFile() {
    return DesignPattern.persistValue(
      'entityNameFile',
      '{{name.snakeCase}}_entity',
    );
  }

  @override
  String path() {
    return DesignPattern.persistValue(
      'entityPath',
      'domain/models/entities',
    );
  }

  @override
  String nameClass() {
    return DesignPattern.persistValue(
      'entityNameClass',
      '{{name.pascalCase}}Entity',
    );
  }

  @override
  String template() {
    return DesignPattern.readTemplete(
      'entity.template',
      _template,
      ReservedWords.removeWordsInFile(
        fileString: path(),
      ),
    );
  }

  @override
  String nameDesignPattern() {
    return 'entity';
  }

  @override
  String extension() {
    return DesignPattern.persistValue(
      'entityExtension',
      'dart',
    );
  }
}
