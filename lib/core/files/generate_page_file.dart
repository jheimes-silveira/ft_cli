import 'dart:io';

import 'package:js_cli/core/utils/directory_utils.dart';
import 'package:js_cli/core/utils/reserved_words.dart';

import 'configs_file.dart';

class GeneratePageFile {
  static String template = r'''
import 'package:flutter/material.dart';
import '{{controllerNameFile.snakeCase}}.dart';

class {{pageNameClass.pascalCase}} extends StatefulWidget {

  @override
  _{{pageNameClass.pascalCase}}State createState() => _{{pageNameClass.pascalCase}}State();
}

class _{{name.pascalCase}}PageState extends State<{{pageNameClass.pascalCase}}> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(),
      body: Container(),
    );
  }
}
          
          ''';
  static String readImp(String name) {
    return _read(
      name,
      'page.template',
      template,
      ReservedWords.removeWordsInFile(
        fileString: ConfigsFile.getPagePath(),
      ),
    );
  }

  static String _read(
    String name,
    String file,
    String template,
    String path,
  ) {
    var root = '.js_cli';

    path = 'template/$path';

    var existFile = File('$root/$path/$file').existsSync();

    if (!existFile) {
      DirectoryUtils.create(root, path);
      File('$root/$path/$file').writeAsStringSync(template);
    }

    return File('$root/$path/$file').readAsStringSync();
  }
}
