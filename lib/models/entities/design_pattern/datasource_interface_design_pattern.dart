import 'package:ft_cli/core/utils/bool_utils.dart';
import 'package:ft_cli/core/utils/reserved_words.dart';
import 'package:ft_cli/models/entities/design_pattern/design_pattern.dart';

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
      'template',
      'datasource_interface.template',
      _template,
      ReservedWords.removeWordsInFile(
        fileString: path(),
      ),
    );
  }

  @override
  String nameDesignPattern() {
    return 'datasource_interface';
  }

  @override
  String extension() {
    return persistValue(
      'datasourceExtensionInterface',
      'dart',
    );
  }

  @override
  bool generate() {
    return BoolUtils.parse(persistValue(
      'datasourceGenerateInterface',
      true,
    ));
  }
}
