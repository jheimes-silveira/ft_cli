import 'dart:io';

import 'package:recase/recase.dart';

import '../../../../core/errors/file_exists_error.dart';
import '../../../../core/interfaces/igenerate_datasources.dart';
import '../../../../core/templates/core/generic_template.dart';

class GenerateDatasources implements IGenerateDatasources {
  @override
  Future<bool> call({
    required String datasourceName,
    required String path,
    required String subPath,
    required String subPathInterface,
  }) async {
    var completePathI =
        '$path/$subPathInterface/${ReCase(datasourceName).snakeCase}_datasource.dart';
    var completePath =
        '$path/$subPath/${ReCase(datasourceName).snakeCase}_imp_datasource.dart';

    if (File(completePath).existsSync()) {
      throw FileExistsError(innerException: Exception());
    }

    if (File(completePathI).existsSync()) {
      throw FileExistsError(innerException: Exception());
    }

    File(completePathI).createSync(recursive: true);
    var contentInterface = layerTemplateInterface(datasourceName, 'datasource');
    File(completePathI).writeAsStringSync(contentInterface);

    File(completePath).createSync(recursive: true);
    var content = layerTemplate(
      datasourceName,
      'datasource',
      outerLayer: '../../data/datasources/',
    );

    File(completePathI).writeAsStringSync(content);

    updateIntegrationModule(
      path,
      '${datasourceName}ImpDatasource',
      subPath,
    );

    return true;
  }
}
