import 'dart:io';

import '../../../../core/errors/file_exists_error.dart';
import '../../../../core/interfaces/igenerate_dto.dart';
import '../../../../core/templates/data/dtos/dto_template.dart';
import 'package:recase/recase.dart';

class GenerateDto implements IGenerateDto {
  @override
  Future<bool> call({
    required String dtoName,
    required String path,
    required String subPath,
  }) async {
    var isValidDirectory = await Directory(path).exists();
    if (isValidDirectory) {
      var completePath = '$path/$subPath/${ReCase(dtoName).snakeCase}_dto.dart';

      var existFile = await File(completePath).exists();
      if (existFile) throw FileExistsError(innerException: Exception());

      File(completePath).createSync(recursive: true);
      var content = dtoTemplate(dtoName);
      File(completePath).writeAsStringSync(content);
      return true;
    } else {
      return false;
    }
  }
}
