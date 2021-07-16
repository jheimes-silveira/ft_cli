import 'dart:io';

import '../../../../core/errors/file_exists_error.dart';
import '../../../../core/interfaces/igenerate_dto.dart';
import '../../../../core/templates/data/dtos/dto_template.dart';
import 'package:recase/recase.dart';

class GenerateDto implements IGenerateDto {
  @override
  Future<bool> call(String dtoName, String path) async {
    var isValidDirectory = await Directory(path).exists();
    if (isValidDirectory) {
      var existFile =
          await File('$path/${ReCase(dtoName).snakeCase}.dto.dart').exists();

      if (existFile) throw FileExistsError(innerException: Exception());

      File('$path/${ReCase(dtoName).snakeCase}.dto.dart')
          .createSync(recursive: true);
      var content = dtoTemplate(dtoName);
      File('$path/${ReCase(dtoName).snakeCase}.dto.dart')
          .writeAsStringSync(content);
      return true;
    } else {
      return false;
    }
  }
}
