
import 'package:js_cli/core/utils/reserved_words.dart';
import 'package:js_cli/app/domain/models/entities/design_pattern.dart';

class DatasourceDesignPattern implements DesignPattern {
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
       return DesignPattern.persistValue(
      'datasourceNameFile',
      '{{name.snakeCase}}_imp_datasource',
    );
  }

  @override
  String path() {
        return DesignPattern.persistValue(
      'datasourcePath',
      'external/datasources',
    );
  }

  @override
  String nameClass() {
        return DesignPattern.persistValue(
      'datasourceNameClass',
      '{{name.pascalCase}}ImpDatasource',
    );
  }

  @override
  String template() {
    return DesignPattern.readTemplete(
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
    return DesignPattern.persistValue(
      'datasourceExtension',
      'dart',
    );
  }
}
