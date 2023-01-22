import 'package:ft_cli/core/utils/bool_utils.dart';
import 'package:ft_cli/core/utils/reserved_words.dart';
import 'package:ft_cli/models/entities/design_pattern/design_pattern.dart';

class PageDesignPattern extends DesignPattern {
  static const String _template = '''
import 'package:flutter/material.dart';
import '{{controllerNameFile}}.{{controllerExtension}}';

class {{pageNameClass}} extends StatefulWidget {
  const {{pageNameClass}}({super.key});

  @override
  State<{{pageNameClass}}> createState() => _{{pageNameClass}}State();
}

class _{{pageNameClass}}State extends State<{{pageNameClass}}> {
  final _controller = {{controllerNameClass}}();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('{{pageNameClass.sentenceCase}}'),
      ),
      body: Container(),
    );
  }
}
  ''';

  @override
  String nameFile() {
    return persistValue(
      'pageNameFile',
      '{{name.snakeCase}}_page',
    );
  }

  @override
  String path() {
    return persistValue(
      'pagePath',
      'presentation/ui/pages/{{name.snakeCase}}',
    );
  }

  @override
  String nameClass() {
    return persistValue(
      'pageNameClass',
      '{{name.pascalCase}}Page',
    );
  }

  @override
  String template() {
    return readTemplete(
      'template',
      'page.template',
      _template,
      ReservedWords.removeWordsInFile(
        fileString: path(),
      ),
    );
  }

  @override
  String nameDesignPattern() {
    return 'page';
  }

  @override
  String extension() {
    return persistValue(
      'pageExtension',
      'dart',
    );
  }

  @override
  bool generate() {
    return BoolUtils.parse(persistValue(
      'pageGenerate',
      true,
    ));
  }
}
