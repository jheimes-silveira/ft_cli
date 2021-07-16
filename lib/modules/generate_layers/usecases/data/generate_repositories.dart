import 'dart:io';

import '../../../../core/errors/file_exists_error.dart';
import '../../../../core/interfaces/igenerate_repositories.dart';
import '../../../../core/templates/core/generic_template.dart';
import 'package:recase/recase.dart';

class GenerateRepositories implements IGenerateRepositories {
  @override
  Future<bool> call(
    String repositoryName,
    String path,
    String pathInterface,
  ) async {
    var isValidDirectoryInferface = await Directory(pathInterface).exists();
    var isValidDirectory = await Directory(path).exists();

    var existFile = await File(
            '$pathInterface/${ReCase(repositoryName).snakeCase}.repository.dart')
        .exists();

    if (existFile) {
      throw FileExistsError(innerException: Exception());
    }

    existFile = await File(
            '$path/${ReCase(repositoryName).snakeCase}_imp.repository.dart')
        .exists();

    if (existFile) {
      throw FileExistsError(innerException: Exception());
    }

    if (isValidDirectory && isValidDirectoryInferface) {
      File('$pathInterface/${ReCase(repositoryName).snakeCase}.repository.dart')
          .createSync(recursive: true);
      var contentInterface =
          layerTemplateInterface(repositoryName, 'repository');
      File('$pathInterface/${ReCase(repositoryName).snakeCase}.repository.dart')
          .writeAsStringSync(contentInterface);

      File('$path/${ReCase(repositoryName).snakeCase}_imp.repository.dart')
          .createSync(recursive: true);
      var content = layerTemplate(
        repositoryName,
        'repository',
        outerLayer: '../../domain/repositories/',
      );
      File('$path/${ReCase(repositoryName).snakeCase}_imp.repository.dart')
          .writeAsStringSync(content);
      return true;
    } else {
      return false;
    }
  }
}
