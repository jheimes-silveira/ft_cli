import 'package:js_cli/core/utils/reserved_words.dart';
import 'package:js_cli/models/entities/design_pattern/design_pattern.dart';

class DatasourceInterfaceDesignPattern extends DesignPattern {
  static const _template = '''
abstract class {{datasourceNameClassInterface.pascalCase}} {
  Future<void> call();
}
  ''';

  @override
  String nameFile() {
    return persistValue(
      'datasourceNameFileInterface',
      '{{name.snakeCase}}_datasource',
    );
  }

  @override
  String path() {
    return persistValue(
      'datasourcePathInterface',
      'data/datasources',
    );
  }

  @override
  String nameClass() {
    return persistValue(
      'datasourceNameClassInterface',
      '{{name.pascalCase}}Datasource',
    );
  }

  @override
  String template() {
    return readTemplete(
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
    return persistValue(
      'datasourceExtensionInterface',
      'dart',
    );
  }
}
