import 'dart:io';

import '../../../../core/errors/file_exists_error.dart';
import '../../../../core/interfaces/igenerate_usecases.dart';
import '../../../../core/templates/domain/usecases/usecase_template.dart';
import 'package:recase/recase.dart';

class GenerateUsecases implements IGenerateUsecases {
  @override
  Future<bool> call(String usecaseName, String path) async {
    var isValidDirectory = await Directory(path).exists();

    var existFile =
        await File('$path/${ReCase(usecaseName).snakeCase}.usecase.dart')
            .exists();

    if (existFile) {
      throw FileExistsError(innerException: Exception());
    }

    existFile =
        await File('$path/${ReCase(usecaseName).snakeCase}_imp.usecase.dart')
            .exists();

    if (existFile) {
      throw FileExistsError(innerException: Exception());
    }

    if (isValidDirectory) {
      File('$path/${ReCase(usecaseName).snakeCase}.usecase.dart')
          .createSync(recursive: true);
      var contentInterface = usecaseTemplateInterface(usecaseName);
      File('$path/${ReCase(usecaseName).snakeCase}.usecase.dart')
          .writeAsStringSync(contentInterface);

      File('$path/${ReCase(usecaseName).snakeCase}_imp.usecase.dart')
          .createSync(recursive: true);
      var content = usecaseTemplate(usecaseName);
      File('$path/${ReCase(usecaseName).snakeCase}_imp.usecase.dart')
          .writeAsStringSync(content);
      return true;
    } else {
      return false;
    }
  }
}
