import 'package:js_cli/core/utils/reserved_words.dart';
import 'package:js_cli/app/domain/models/entities/design_pattern.dart';

class ControllerDesignPattern implements DesignPattern {
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
    return DesignPattern.persistValue(
      'controllerNameFile',
      '{{name.snakeCase}}_controller',
    );
  }

  @override
  String path() {
    return DesignPattern.persistValue(
      'controllerPath',
      'presentation/ui/pages/{{name.snakeCase}}',
    );
  }

  @override
  String nameClass() {
    return DesignPattern.persistValue(
      'controllerNameClass',
      '{{name.pascalCase}}Controller',
    );
  }

  @override
  String template() {
    return DesignPattern.readTemplete(
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
    return DesignPattern.persistValue(
      'controllerExtension',
      'dart',
    );
  }
}
