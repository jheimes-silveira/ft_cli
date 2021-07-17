import 'dart:io';

import 'package:recase/recase.dart';

import '../../../../core/errors/file_exists_error.dart';
import '../../../../core/interfaces/igenerate_entity.dart';
import '../../../../core/templates/domain/entities/entity_template.dart';

class GenerateEntity implements IGenerateEntity {
  @override
  Future<bool> call({
    required String entityName,
    required String path,
    required String subPath,
  }) async {
    var isValidDirectory = await Directory(path).exists();
    var completePath =
        '$path/$subPath/${ReCase(entityName).snakeCase}_entity.dart';
    if (isValidDirectory) {
      var existFile = await File(completePath).exists();

      if (existFile) {
        throw FileExistsError(innerException: Exception());
      }

      File(completePath).createSync(recursive: true);
      var content = entityTemplate(entityName);
      File(completePath).writeAsStringSync(content);
      return true;
    } else {
      return false;
    }
  }
}
