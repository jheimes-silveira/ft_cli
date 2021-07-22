import 'dart:io';

class GenerateNonePageFile {
  static String templete = r'''
import 'package:flutter/material.dart';

class None extends StatefulWidget {

  @override
  _NoneState createState() => _NoneState();
}

class _NoneState extends State<None> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
          ''';

  static String read() {
    var existFile =
        File('.js_cli/template/integration/none/generate_none_page.template')
            .existsSync();

    if (!existFile) {
      Directory('.js_cli/template/integration/none/generate_none_page.template')
          .createSync();

      File('.js_cli/template/integration/none/generate_none_page.template')
          .writeAsStringSync(templete);
    }

    return File('.js_cli/template/integration/none/generate_none_page.template')
        .readAsStringSync();
  }
}
