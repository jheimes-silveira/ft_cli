import 'dart:io';

import 'package:js_cli/core/interfaces/igenerate_repositories.dart';
import 'package:js_cli/core/utils/file_configs.dart';
import 'package:recase/recase.dart';

import '../../../../core/errors/file_exists_error.dart';
import '../../../../core/templates/core/generic_template.dart';

class GenerateRepositories implements IGenerateRepositories {
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
    final configs = FileConfigs.read();

    if (!configs.containsKey('repositoryNameClass')) {
      configs['repositoryNameClass'] = '{{name}}ImpRepository';
      FileConfigs.write(configs);
    }

    return (configs['repositoryNameClass'] as String).replaceAll(
      '{{name}}',
      name,
    );
  }

  @override
  String getNameClassInterface(String name) {
    final configs = FileConfigs.read();

    if (!configs.containsKey('repositoryNameClassInterface')) {
      configs['repositoryNameClassInterface'] = '{{name}}Repository';
      FileConfigs.write(configs);
    }

    return (configs['repositoryNameClassInterface'] as String).replaceAll(
      '{{name}}',
      name,
    );
  }

  @override
  String getNameFile(String name) {
    final configs = FileConfigs.read();

    if (!configs.containsKey('repositoryNameFile')) {
      configs['repositoryNameFile'] = '{{name}}_imp_repository';
      FileConfigs.write(configs);
    }

    return (configs['repositoryNameFile'] as String).replaceAll(
      '{{name}}',
      ReCase(name).snakeCase,
    );
  }

  @override
  String getNameFileInterface(String name) {
    final configs = FileConfigs.read();

    if (!configs.containsKey('repositoryNameFileInterface')) {
      configs['repositoryNameFileInterface'] = '{{name}}_repository';
      FileConfigs.write(configs);
    }

    return (configs['repositoryNameFileInterface'] as String).replaceAll(
      '{{name}}',
      ReCase(name).snakeCase,
    );
  }

  @override
  String getPath() {
    final configs = FileConfigs.read();

    if (!configs.containsKey('repositoryPath')) {
      configs['repositoryPath'] = 'data/repositories';
      FileConfigs.write(configs);
    }

    return (configs['repositoryPath'] as String);
  }

  @override
  String getPathInterface() {
    final configs = FileConfigs.read();

    if (!configs.containsKey('repositoryPathInterface')) {
      configs['repositoryPathInterface'] = 'domain/repositories';
      FileConfigs.write(configs);
    }

    return (configs['repositoryPathInterface'] as String);
  }
}
