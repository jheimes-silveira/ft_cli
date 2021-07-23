import 'dart:io';

import 'package:js_cli/core/files/configs_file.dart';

class GeneratePageFile {
  static String templeteNone = r'''
import 'package:flutter/material.dart';
import '{{controllerNameFile.snakeCase}}.dart';

class {{name.pascalCase}} extends StatefulWidget {

  @override
  _{{name.pascalCase}}State createState() => _{{name.pascalCase}}State();
}

class _{{name.pascalCase}}State extends State<{{pageNameClass.pascalCase}}> {
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
  static String templeteFlutterModular = r'''
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '{{controllerNameFile.snakeCase}}.dart';

class {{name.pascalCase}} extends StatefulWidget {

  @override
  _{{name.pascalCase}}State createState() => _{{name.pascalCase}}State();
}

class _{{name.pascalCase}}State extends ModularState<{{pageNameClass.pascalCase}}, {{controllerNameClass.pascalCase}}> {
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

  static String read() {
    final integration = ConfigsFile.getIntegration();
    var path;
    var templete;
    if (integration == 'flutter_modular') {
      path = 'generate_flutter_modular_page.template';
      templete = templeteFlutterModular;
    } else {
      path = 'generate_none_page.template';
      templete = templeteNone;
    }

    var existFile = File('.js_cli/template/$path').existsSync();

    if (!existFile) {
      Directory('.js_cli').createSync();
      Directory('.js_cli/template').createSync();
  
      File('.js_cli/template/$path').writeAsStringSync(templete);
    }

    return File('.js_cli/template/$path').readAsStringSync();
  }
}
