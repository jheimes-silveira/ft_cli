import 'dart:io';

import 'package:js_cli/core/interfaces/igenerate_datasources.dart';
import 'package:js_cli/core/utils/file_configs.dart';
import 'package:recase/recase.dart';

import '../../../../core/errors/file_exists_error.dart';
import '../../../../core/templates/core/generic_template.dart';

class GenerateDatasources implements IGenerateDatasources {
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

    if (!configs.containsKey('datasourceNameClass')) {
      configs['datasourceNameClass'] = '{{name}}ImpDatasource';
      FileConfigs.write(configs);
    }

    return (configs['datasourceNameClass'] as String).replaceAll(
      '{{name}}',
      name,
    );
  }

  @override
  String getNameClassInterface(String name) {
    final configs = FileConfigs.read();

    if (!configs.containsKey('datasourceNameClassInterface')) {
      configs['datasourceNameClassInterface'] = '{{name}}Datasource';
      FileConfigs.write(configs);
    }

    return (configs['datasourceNameClassInterface'] as String).replaceAll(
      '{{name}}',
      name,
    );
  }

  @override
  String getNameFile(String name) {
    final configs = FileConfigs.read();

    if (!configs.containsKey('datasourceNameFile')) {
      configs['datasourceNameFile'] = '{{name}}_imp_datasource';
      FileConfigs.write(configs);
    }

    return (configs['datasourceNameFile'] as String).replaceAll(
      '{{name}}',
      ReCase(name).snakeCase,
    );
  }

  @override
  String getNameFileInterface(String name) {
    final configs = FileConfigs.read();

    if (!configs.containsKey('datasourceNameFileInterface')) {
      configs['datasourceNameFileInterface'] = '{{name}}_datasource';
      FileConfigs.write(configs);
    }

    return (configs['datasourceNameFileInterface'] as String).replaceAll(
      '{{name}}',
      ReCase(name).snakeCase,
    );
  }

  @override
  String getPath() {
    final configs = FileConfigs.read();

    if (!configs.containsKey('datasourcePath')) {
      configs['datasourcePath'] = 'data/datasources';
      FileConfigs.write(configs);
    }

    return (configs['datasourcePath'] as String);
  }

  @override
  String getPathInterface() {
    final configs = FileConfigs.read();

    if (!configs.containsKey('datasourcePathInterface')) {
      configs['datasourcePathInterface'] = 'external/datasources';
      FileConfigs.write(configs);
    }

    return (configs['datasourcePathInterface'] as String);
  }
}
