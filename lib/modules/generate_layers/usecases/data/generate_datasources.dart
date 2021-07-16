import 'dart:io';

import '../../../../core/errors/file_exists_error.dart';
import '../../../../core/interfaces/igenerate_datasources.dart';
import '../../../../core/templates/core/generic_template.dart';
import 'package:recase/recase.dart';

class GenerateDatasources implements IGenerateDatasources {
  @override
  Future<bool> call(
    String datasourceName,
    String path,
    String pathInterface,
  ) async {
    var isValidDirectoryInferface = await Directory(pathInterface).exists();
    var isValidDirectory = await Directory(path).exists();

    var existFile = await File(
            '$pathInterface/${ReCase(datasourceName).snakeCase}.datasource.dart')
        .exists();

    if (existFile) {
      throw FileExistsError(innerException: Exception());
    }

    existFile = await File(
            '$path/${ReCase(datasourceName).snakeCase}_imp.datasource.dart')
        .exists();

    if (existFile) {
      throw FileExistsError(innerException: Exception());
    }

    if (isValidDirectory && isValidDirectoryInferface) {
      File('$pathInterface/${ReCase(datasourceName).snakeCase}.datasource.dart')
          .createSync(recursive: true);
      var contentInterface =
          layerTemplateInterface(datasourceName, 'datasource');
      File('$pathInterface/${ReCase(datasourceName).snakeCase}.datasource.dart')
          .writeAsStringSync(contentInterface);

      File('$path/${ReCase(datasourceName).snakeCase}_imp.datasource.dart')
          .createSync(recursive: true);
      var content = layerTemplate(
        datasourceName,
        'datasource',
        outerLayer: '../../data/datasources/',
      );
      File('$path/${ReCase(datasourceName).snakeCase}_imp.datasource.dart')
          .writeAsStringSync(content);
      return true;
    } else {
      return false;
    }
  }
}
