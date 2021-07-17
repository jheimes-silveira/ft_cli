import 'dart:io';

import 'package:js_cli/core/templates/core/generic_template.dart';
import 'package:recase/recase.dart';

import '../../../../core/errors/file_exists_error.dart';
import '../../../../core/interfaces/igenerate_usecases.dart';

class GenerateUsecases implements IGenerateUsecases {
  @override
  Future<bool> call(String usecaseName, String path, String subPath) async {
    if (!(Directory(path).existsSync())) return false;

    var completePathI =
        '$path/$subPath/${ReCase(usecaseName).snakeCase}_usecase.dart';
    var completePath =
        '$path/$subPath/${ReCase(usecaseName).snakeCase}_imp_usecase.dart';

    if (File(completePathI).existsSync()) {
      throw FileExistsError(innerException: Exception());
    }

    if (File(completePath).existsSync()) {
      throw FileExistsError(innerException: Exception());
    }

    File(completePathI).createSync(recursive: true);
    var contentInterface = layerTemplateInterface(usecaseName, 'usecase');
    File(completePathI).writeAsStringSync(contentInterface);

    File(completePath).createSync(recursive: true);
    var content = layerTemplate(usecaseName, 'usecase');

    File(completePath).writeAsStringSync(content);

    updateIntegrationModule(
      path,
      '${usecaseName}ImpUsecase',
      subPath,
    );
    return true;
  }
}
