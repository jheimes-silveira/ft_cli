import 'package:js_cli/core/utils/reserved_words.dart';
import 'package:js_cli/app/domain/models/entities/design_pattern.dart';

class DatasourceInterfaceDesignPattern implements DesignPattern {
  static const _template = '''
abstract class {{datasourceNameClassInterface.pascalCase}} {
  Future<void> call();
}
  ''';

  @override
  String nameFile() {
    return DesignPattern.persistValue(
      'datasourceNameFileInterface',
      '{{name.snakeCase}}_datasource',
    );
  }

  @override
  String path() {
    return DesignPattern.persistValue(
      'datasourcePathInterface',
      'data/datasources',
    );
  }

  @override
  String nameClass() {
    return DesignPattern.persistValue(
      'datasourceNameClassInterface',
      '{{name.pascalCase}}Datasource',
    );
  }

  @override
  String template() {
    return DesignPattern.readTemplete(
      'datasource_interface.template',
      _template,
      ReservedWords.removeWordsInFile(
        fileString: path(),
      ),
    );
  }

  @override
  String nameDesignPattern() {
    return 'datasource';
  }

  @override
  String extension() {
    return DesignPattern.persistValue(
      'datasourceExtensionInterface',
      'dart',
    );
  }
}
