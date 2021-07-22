import 'dart:io';

import 'package:js_cli/core/files/configs_file.dart';
import 'package:js_cli/core/interfaces/igenerate_usecases.dart';
import 'package:js_cli/core/templates/core/generic_template.dart';
import 'package:recase/recase.dart';

import '../../../../core/errors/file_exists_error.dart';

class GenerateUsecases implements IGenerateUsecases {
  @override
  Future<bool> call({
    required String name,
    required String path,
  }) async {
    if (!(Directory(path).existsSync())) return false;

    var completePathI =
        '$path/${getPathInterface()}/${getNameFileInterface(name)}.dart';
    var completePath = '$path/${getPath()}/${getNameFile(name)}.dart';

    if (File(completePathI).existsSync()) {
      throw FileExistsError(innerException: Exception());
    }

    if (File(completePath).existsSync()) {
      throw FileExistsError(innerException: Exception());
    }

    File(completePathI).createSync(recursive: true);

    var contentInterface = layerTemplateInterface(
      getNameClassInterface(name),
    );

    File(completePathI).writeAsStringSync(contentInterface);

    File(completePath).createSync(recursive: true);

    var content = layerTemplate(
      nameFileInterface: getNameFileInterface(name),
      nameClass: getNameClass(name),
      nameClassInterface: getNameClassInterface(name),
      nameFile: getNameFile(name),
      pathInterface: getPathInterface(),
      path: getPath(),
    );

    File(completePath).writeAsStringSync(content);

    updateIntegrationModule(
      path,
      getNameClass(name),
      getPath(),
    );
    return true;
  }

  @override
  String getNameClass(String name) {
    return (ConfigsFile.getUsecaseNameClass()).replaceAll(
      '{{name}}',
      name,
    );
  }

  @override
  String getNameClassInterface(String name) {
    return (ConfigsFile.getUsecaseNameClassInterface()).replaceAll(
      '{{name}}',
      name,
    );
  }

  @override
  String getNameFile(String name) {
    return (ConfigsFile.getUsecaseNameFile()).replaceAll(
      '{{name}}',
      ReCase(name).snakeCase,
    );
  }

  @override
  String getNameFileInterface(String name) {
    return (ConfigsFile.getUsecaseNameFileInterface()).replaceAll(
      '{{name}}',
      ReCase(name).snakeCase,
    );
  }

  @override
  String getPath() {
    return ConfigsFile.getUsecasePath();
  }

  @override
  String getPathInterface() {
    return (ConfigsFile.getUsecasePathInterface());
  }
}
