import 'dart:io';

import 'package:js_cli/core/files/configs_file.dart';
import 'package:js_cli/core/interfaces/igenerate_repositories.dart';
import 'package:js_cli/core/utils/directory_utils.dart';
import 'package:js_cli/core/utils/reserved_words.dart';

import '../../../../core/errors/file_exists_error.dart';
import '../../../../core/templates/core/generic_template.dart';

class GenerateRepositories implements IGenerateRepositories {
  @override
  Future<bool> call({
    required String name,
    required String path,
  }) async {
    DirectoryUtils.create(
      path,
      ReservedWords.replaceWordsInFile(
        fileString: getPath(),
        name: name,
      ),
    );
    DirectoryUtils.create(
      path,
      ReservedWords.replaceWordsInFile(
        fileString: getPathInterface(),
        name: name,
      ),
    );

    var completePath = ReservedWords.replaceWordsInFile(
      fileString: '$path/${getPath()}/${getNameFile(name)}.dart',
      name: name,
    );
    var completePathI = ReservedWords.replaceWordsInFile(
      fileString:
          '$path/${getPathInterface()}/${getNameFileInterface(name)}.dart',
      name: name,
    );

    if (File(completePathI).existsSync()) {
      throw FileExistsError(innerException: Exception());
    }

    if (File(completePath).existsSync()) {
      throw FileExistsError(innerException: Exception());
    }

    File(completePathI).createSync(recursive: true);

    var contentInterface = layerTemplateInterface(
      getNameClassInterface(name),
    );

    File(completePathI).writeAsStringSync(contentInterface);

    File(completePath).createSync(recursive: true);

    var content = layerTemplate(
      nameFileInterface: getNameFileInterface(name),
      nameClass: getNameClass(name),
      nameClassInterface: getNameClassInterface(name),
      nameFile: getNameFile(name),
      pathInterface: getPathInterface(),
      path: getPath(),
    );

    File(completePath).writeAsStringSync(content);

    updateIntegrationModule(
      path,
      getNameClass(name),
      getPath(),
    );
    return true;
  }

  @override
  String getNameClass(String name) {
    return ReservedWords.replaceWordsInFile(
      fileString: ConfigsFile.getRepositoryNameClass(),
      name: name,
    );
  }

  @override
  String getNameClassInterface(String name) {
    return ReservedWords.replaceWordsInFile(
      fileString: ConfigsFile.getRepositoryNameClassInterface(),
      name: name,
    );
  }

  @override
  String getNameFile(String name) {
    return ReservedWords.replaceWordsInFile(
      fileString: ConfigsFile.getRepositoryNameFile(),
      name: name,
    );
  }

  @override
  String getNameFileInterface(String name) {
    return ReservedWords.replaceWordsInFile(
      fileString: ConfigsFile.getRepositoryNameFileInterface(),
      name: name,
    );
  }

  @override
  String getPath() {
    return ConfigsFile.getRepositoryPath();
  }

  @override
  String getPathInterface() {
    return (ConfigsFile.getRepositoryPathInterface());
  }
}
