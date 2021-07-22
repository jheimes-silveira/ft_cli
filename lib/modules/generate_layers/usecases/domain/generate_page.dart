import 'dart:io';

import 'package:js_cli/core/files/configs_file.dart';
import 'package:js_cli/core/files/generate_none_page_file.dart';
import 'package:js_cli/core/interfaces/igenerate_page.dart';
import 'package:recase/recase.dart';

import '../../../../core/errors/file_exists_error.dart';

class GeneratePages implements IGeneratePages {
  @override
  Future<bool> call({
    required String name,
    required String path,
  }) async {
    if (!(Directory(path).existsSync())) return false;

    var completePath = '$path/${getPath()}/${getNameFile(name)}.dart';

    if (File(completePath).existsSync()) {
      throw FileExistsError(innerException: Exception());
    }

    // var content = GenerateNonePageFile.read();
    var content = 
    "camelCase: ${name.camelCase} \n"
    "constantCase: ${name.constantCase} \n"
    +"sentenceCase: ${name.sentenceCase}\n" 
    +"snakeCase: ${name.snakeCase}\n" 
    +"dotCase: ${name.dotCase}\n" 
    +"paramCase: ${name.paramCase}\n" 
    +"pathCase: ${name.pathCase}\n" 
    +"pascalCase: ${name.pascalCase}\n" 
    +"headerCase: ${name.headerCase}\n" 
    +"titleCase: ${name.titleCase}\n"; 










    File(completePath).writeAsStringSync(content);

    // updateIntegrationModule(
    //   path,
    //   getNameClass(name),
    //   getPath(),
    // );
    return true;
  }

  @override
  String getNameClass(String name) {
    final configs = ConfigsFile.read();

    if (!configs.containsKey('pageNameClass')) {
      configs['pageNameClass'] = '{{name}}Page';
      ConfigsFile.write(configs);
    }

    return (configs['pageNameClass'] as String).replaceAll(
      '{{name}}',
      name,
    );
  }

  @override
  String getNameFile(String name) {
    final configs = ConfigsFile.read();

    if (!configs.containsKey('pageNameFile')) {
      configs['pageNameFile'] = '{{name}}_page';
      ConfigsFile.write(configs);
    }

    return (configs['pageNameFile'] as String).replaceAll(
      '{{name}}',
      ReCase(name).snakeCase,
    );
  }

  @override
  String getPath() {
    final configs = ConfigsFile.read();

    if (!configs.containsKey('pagePath')) {
      configs['pagePath'] = 'presentation/ui/pages';
      ConfigsFile.write(configs);
    }

    return (configs['pagePath'] as String);
  }
}
