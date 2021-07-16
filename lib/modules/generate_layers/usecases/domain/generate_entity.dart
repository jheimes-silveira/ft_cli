import 'dart:io';

import '../../../../core/errors/file_exists_error.dart';
import '../../../../core/interfaces/igenerate_entity.dart';
import '../../../../core/templates/domain/entities/entity_template.dart';
import 'package:recase/recase.dart';

class GenerateEntity implements IGenerateEntity {
  @override
  Future<bool> call(String entityName, String path) async {
    var isValidDirectory = await Directory(path).exists();
    if (isValidDirectory) {
      var existFile =
          await File('$path/${ReCase(entityName).snakeCase}.entity.dart')
              .exists();

      if (existFile) {
        throw FileExistsError(innerException: Exception());
      }

      File('$path/${ReCase(entityName).snakeCase}.entity.dart')
          .createSync(recursive: true);
      var content = entityTemplate(entityName);
      File('$path/${ReCase(entityName).snakeCase}.entity.dart')
          .writeAsStringSync(content);
      return true;
    } else {
      return false;
    }
  }
}
