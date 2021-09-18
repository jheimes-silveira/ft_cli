import 'package:ft_cli/core/utils/reserved_words.dart';
import 'package:ft_cli/models/entities/design_pattern/design_pattern.dart';

class DatasourceDesignPattern extends DesignPattern {
  static const String _template = '''
import '../../{{datasourcePathInterface}}/{{datasourceNameFileInterface.snakeCase}}.dart';

class {{datasourceNameClass.pascalCase}} implements {{datasourceNameClassInterface.pascalCase}} {
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
      'datasourceNameFile',
      '{{name.snakeCase}}_imp_datasource',
    );
  }

  @override
  String path() {
    return persistValue(
      'datasourcePath',
      'external/datasources',
    );
  }

  @override
  String nameClass() {
    return persistValue(
      'datasourceNameClass',
      '{{name.pascalCase}}ImpDatasource',
    );
  }

  @override
  String template() {
    return readTemplete(
      'template',
      'datasource.template',
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
      'datasourceExtension',
      'dart',
    );
  }
}
