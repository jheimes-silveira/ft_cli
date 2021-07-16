import 'dart:io';

import '../../../../core/errors/file_exists_error.dart';
import '../../../../core/interfaces/igenerate_error.dart';
import '../../../../core/templates/core/errors/error_template.dart';
import 'package:recase/recase.dart';

class GenerateError implements IGenerateError {
  @override
  Future<bool> call(String errorName, String path) async {
    var isValidDirectory = await Directory(path).exists();

    if (isValidDirectory) {
      var existFile =
          await File('$path/${ReCase(errorName).snakeCase}.error.dart')
              .exists();

      if (existFile) {
        throw FileExistsError(innerException: Exception());
      }

      File('$path/${ReCase(errorName).snakeCase}.error.dart')
          .createSync(recursive: true);
      var content = errorTemplate(errorName);

      File('$path/${ReCase(errorName).snakeCase}.error.dart')
          .writeAsStringSync(content);
      return true;
    } else {
      return false;
    }
  }
}
