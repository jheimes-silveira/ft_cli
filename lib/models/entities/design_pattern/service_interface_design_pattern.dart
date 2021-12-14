import 'package:ft_cli/core/utils/bool_utils.dart';
import 'package:ft_cli/core/utils/reserved_words.dart';
import 'package:ft_cli/models/entities/design_pattern/design_pattern.dart';

class ServiceInterfaceDesignPattern extends DesignPattern {
  static const _template = '''
abstract class {{serviceNameClassInterface.pascalCase}} {
  Future<void> call();
}
  ''';

  @override
  String nameFile() {
    return persistValue(
      'serviceNameFileInterface',
      '{{name.snakeCase}}_service',
    );
  }

  @override
  String path() {
    return persistValue(
      'servicePathInterface',
      'domain/services',
    );
  }

  @override
  String nameClass() {
    return persistValue(
      'serviceNameClassInterface',
      '{{name.pascalCase}}Service',
    );
  }

  @override
  String template() {
    return readTemplete(
      'template',
      'service_interface.template',
      _template,
      ReservedWords.removeWordsInFile(
        fileString: path(),
      ),
    );
  }

  @override
  String nameDesignPattern() {
    return 'service_interface';
  }

  @override
  String extension() {
    return persistValue(
      'serviceExtensionInterface',
      'dart',
    );
  }

  @override
  bool generate() {
    return BoolUtils.parse(persistValue(
      'serviceGenerateInterface',
      true,
    ));
  }
}
