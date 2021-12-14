import 'package:ft_cli/core/utils/bool_utils.dart';
import 'package:ft_cli/core/utils/reserved_words.dart';
import 'package:ft_cli/models/entities/design_pattern/design_pattern.dart';

class ServiceDesignPattern extends DesignPattern {
  static const String _template = '''
import '{{serviceNameFileInterface.snakeCase}}.dart';

class {{serviceNameClass.pascalCase}} implements {{serviceNameClassInterface.pascalCase}} {
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
      'serviceNameFile',
      '{{name.snakeCase}}_imp_service',
    );
  }

  @override
  String path() {
    return persistValue(
      'servicePath',
      'domain/services',
    );
  }

  @override
  String nameClass() {
    return persistValue(
      'serviceNameClass',
      '{{name.pascalCase}}ImpService',
    );
  }

  @override
  String template() {
    return readTemplete(
      'template',
      'service.template',
      _template,
      ReservedWords.removeWordsInFile(
        fileString: path(),
      ),
    );
  }

  @override
  String nameDesignPattern() {
    return 'service';
  }

  @override
  String extension() {
    return persistValue(
      'serviceExtension',
      'dart',
    );
  }

  @override
  bool generate() {
    return BoolUtils.parse(persistValue(
      'serviceGenerate',
      true,
    ));
  }
}
