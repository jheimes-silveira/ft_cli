import 'package:ft_cli/core/utils/reserved_words.dart';
import 'package:ft_cli/models/entities/design_pattern/design_pattern.dart';

class ControllerDesignPattern extends DesignPattern {
  static const String _template = r'''
import 'package:mobx/mobx.dart';
part '{{controllerNameFile.snakeCase}}.g.dart';

class {{controllerNameClass.pascalCase}} = _{{controllerNameClass.pascalCase}}Base with _${{controllerNameClass.pascalCase}};

abstract class _{{controllerNameClass.pascalCase}}Base with Store {
  @observable
  bool loading = false;

  @action
  void setLoading(bool value) {
    loading = value;
  }
}

          ''';

  @override
  String nameFile() {
    return persistValue(
      'controllerNameFile',
      '{{name.snakeCase}}_controller',
    );
  }

  @override
  String path() {
    return persistValue(
      'controllerPath',
      'presentation/ui/pages/{{name.snakeCase}}',
    );
  }

  @override
  String nameClass() {
    return persistValue(
      'controllerNameClass',
      '{{name.pascalCase}}Controller',
    );
  }

  @override
  String template() {
    return readTemplete(
      'template',
      'controller.template',
      _template,
      ReservedWords.removeWordsInFile(
        fileString: path(),
      ),
    );
  }

  @override
  String nameDesignPattern() {
    return 'controller';
  }

  @override
  String extension() {
    return persistValue(
      'controllerExtension',
      'dart',
    );
  }
}
