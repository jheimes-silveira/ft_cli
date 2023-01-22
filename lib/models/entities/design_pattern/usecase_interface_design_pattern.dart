import 'package:ft_cli/core/utils/bool_utils.dart';
import 'package:ft_cli/core/utils/reserved_words.dart';
import 'package:ft_cli/models/entities/design_pattern/design_pattern.dart';

class UsecaseInterfaceDesignPattern extends DesignPattern {
  static const _template = '''
abstract class {{usecaseNameClassInterface}} {
  Future<void> call();
}
  ''';

  @override
  String nameFile() {
    return persistValue(
      'usecaseNameFileInterface',
      '{{name.snakeCase}}_usecase',
    );
  }

  @override
  String path() {
    return persistValue(
      'usecasePathInterface',
      'domain/usecases',
    );
  }

  @override
  String nameClass() {
    return persistValue(
      'usecaseNameClassInterface',
      '{{name.pascalCase}}UseCase',
    );
  }

  @override
  String template() {
    return readTemplete(
      'template',
      'usecase_interface.template',
      _template,
      ReservedWords.removeWordsInFile(
        fileString: path(),
      ),
    );
  }

  @override
  String nameDesignPattern() {
    return 'usecase_interface';
  }

  @override
  String extension() {
    return persistValue(
      'usecaseExtensionInterface',
      'dart',
    );
  }

  @override
  bool generate() {
    return BoolUtils.parse(persistValue(
      'usecaseGenerateInterface',
      true,
    ));
  }
}
