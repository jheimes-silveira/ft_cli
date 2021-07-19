import 'dart:io';
import 'package:js_cli/core/interfaces/igenerate_usecases.dart';
import 'package:js_cli/core/templates/core/generic_template.dart';
import 'package:js_cli/core/utils/file_configs.dart';
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
    final configs = FileConfigs.read();

    if (!configs.containsKey('usecaseNameClass')) {
      configs['usecaseNameClass'] = '{{name}}ImpUsecase';
      FileConfigs.write(configs);
    }

    return (configs['usecaseNameClass'] as String).replaceAll(
      '{{name}}',
      name,
    );
  }

  @override
  String getNameClassInterface(String name) {
    final configs = FileConfigs.read();

    if (!configs.containsKey('usecaseNameClassInterface')) {
      configs['usecaseNameClassInterface'] = '{{name}}Usecase';
      FileConfigs.write(configs);
    }

    return (configs['usecaseNameClassInterface'] as String).replaceAll(
      '{{name}}',
      name,
    );
  }

  @override
  String getNameFile(String name) {
    final configs = FileConfigs.read();

    if (!configs.containsKey('usecaseNameFile')) {
      configs['usecaseNameFile'] = '{{name}}_imp_usecase';
      FileConfigs.write(configs);
    }

    return (configs['usecaseNameFile'] as String).replaceAll(
      '{{name}}',
      ReCase(name).snakeCase,
    );
  }

  @override
  String getNameFileInterface(String name) {
    final configs = FileConfigs.read();

    if (!configs.containsKey('usecaseNameFileInterface')) {
      configs['usecaseNameFileInterface'] = '{{name}}_usecase';
      FileConfigs.write(configs);
    }

    return (configs['usecaseNameFileInterface'] as String).replaceAll(
      '{{name}}',
      ReCase(name).snakeCase,
    );
  }

  @override
  String getPath() {
    final configs = FileConfigs.read();

    if (!configs.containsKey('usecasePath')) {
      configs['usecasePath'] = 'domain/usecases';
      FileConfigs.write(configs);
    }

    return (configs['usecasePath'] as String);
  }

  @override
  String getPathInterface() {
    final configs = FileConfigs.read();

    if (!configs.containsKey('usecasePathInterface')) {
      configs['usecasePathInterface'] = 'domain/usecases';
      FileConfigs.write(configs);
    }

    return (configs['usecasePathInterface'] as String);
  }
}
