import 'dart:io';

import 'package:recase/recase.dart';

import '../../../../core/errors/file_exists_error.dart';
import '../../../../core/interfaces/igenerate_repositories.dart';
import '../../../../core/templates/core/generic_template.dart';

class GenerateRepositories implements IGenerateRepositories {
  @override
  Future<bool> call({
    required String repositoryName,
    required String path,
    required String subPath,
    required String subPathInterface,
  }) async {
    var completePathI =
        '$path/$subPathInterface/${ReCase(repositoryName).snakeCase}_repository.dart';
    var completePath =
        '$path/$subPath/${ReCase(repositoryName).snakeCase}_imp_repository.dart';

    if (Directory(completePathI).existsSync()) {
      throw FileExistsError(innerException: Exception());
    }
    if (Directory(completePath).existsSync()) {
      throw FileExistsError(innerException: Exception());
    }

    File(completePathI).createSync(recursive: true);
    var contentInterface = layerTemplateInterface(repositoryName, 'repository');
    File(completePathI).writeAsStringSync(contentInterface);

    File(completePath).createSync(recursive: true);
    var content = layerTemplate(
      repositoryName,
      'repository',
      outerLayer: '../../domain/repositories/',
    );

    File(completePath).writeAsStringSync(content);

    updateIntegrationModule(
      path,
      '${repositoryName}ImpRepository',
      subPath,
    );

    return true;
  }
}
