import 'dart:io';

import 'package:js_cli/core/files/configs_file.dart';
import 'package:js_cli/core/files/generate_repository_file.dart';
import 'package:js_cli/core/interfaces/igenerate_repositories.dart';
import 'package:js_cli/core/utils/directory_utils.dart';
import 'package:js_cli/core/utils/reserved_words.dart';

import '../../../../core/errors/file_exists_error.dart';
import '../../../../core/utils/replace_utils.dart';

class GenerateRepositories implements IGenerateRepositories {
  @override
  Future<bool> call({
    required String name,
    required String path,
    required String current,
  }) async {
    DirectoryUtils.create(
      path,
      ReservedWords.replaceWordsInFile(
        fileString: getPath(),
        name: name,
        current: current,
      ),
    );
final fileExtension = ConfigsFile.getFileExtension();
    var completePathI = ReservedWords.replaceWordsInFile(
      fileString:
          '$path/${getPathInterface()}/${getNameFileInterface(name, current)}.$fileExtension',
      name: name,
      current: current,
    );

    var completePath = ReservedWords.replaceWordsInFile(
      fileString: '$path/${getPath()}/${getNameFile(name, current)}.$fileExtension',
      name: name,
      current: current,
    );

    if (File(completePathI).existsSync()) {
      throw FileExistsError(innerException: Exception());
    }

    if (File(completePath).existsSync()) {
      throw FileExistsError(innerException: Exception());
    }

    File(completePathI).writeAsStringSync(
      ReservedWords.replaceWordsInFile(
        fileString: GenerateRepositoryFile.readInterface(name),
        name: name,
        path: path,
        current: current,
      ),
    );

    File(completePath).writeAsStringSync(
      ReservedWords.replaceWordsInFile(
        fileString: GenerateRepositoryFile.readImp(name),
        name: name,
        path: path,
        current: current,
      ),
    );

    applyReplaceIfNecessary(
      current: current,
      name: name,
      path: path,
      subPath: ConfigsFile.getRepositoryPath(),
      prefixNameReplaceFile: 'repository',
    );
    return true;
  }

  @override
  String getNameClass(String name, String current) {
    return ReservedWords.replaceWordsInFile(
      fileString: ConfigsFile.getRepositoryNameClass(),
      name: name,
      current: current,
    );
  }

  @override
  String getNameClassInterface(String name, String current) {
    return ReservedWords.replaceWordsInFile(
      fileString: ConfigsFile.getRepositoryNameClassInterface(),
      name: name,
      current: current,
    );
  }

  @override
  String getNameFile(String name, String current) {
    return ReservedWords.replaceWordsInFile(
      fileString: ConfigsFile.getRepositoryNameFile(),
      name: name,
      current: current,
    );
  }

  @override
  String getNameFileInterface(String name, String current) {
    return ReservedWords.replaceWordsInFile(
      fileString: ConfigsFile.getRepositoryNameFileInterface(),
      name: name,
      current: current,
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
