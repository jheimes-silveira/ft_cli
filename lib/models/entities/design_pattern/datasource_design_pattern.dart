import 'package:ft_cli/core/utils/bool_utils.dart';
import 'package:ft_cli/core/utils/reserved_words.dart';
import 'package:ft_cli/models/entities/design_pattern/design_pattern.dart';

class DatasourceDesignPattern extends DesignPattern {
  static const String _template = '''
import '../../{{datasourcePathInterface}}/{{datasourceNameFileInterface}}.{{datasourceExtensionInterface}}';

class {{datasourceNameClass}} implements {{datasourceNameClassInterface}} {
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
      '{{name.snakeCase}}_datasource_impl',
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
      '{{name.pascalCase}}DataSourceImpl',
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

  @override
  bool generate() {
    return BoolUtils.parse(persistValue(
      'datasourceGenerate',
      true,
    ));
  }
}
