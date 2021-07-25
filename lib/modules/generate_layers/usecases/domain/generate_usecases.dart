import 'dart:io';

import 'package:js_cli/core/files/configs_file.dart';
import 'package:js_cli/core/files/generate_usecase_file.dart';
import 'package:js_cli/core/interfaces/igenerate_usecases.dart';
import 'package:js_cli/core/utils/directory_utils.dart';
import 'package:js_cli/core/utils/replace_utils.dart';
import 'package:js_cli/core/utils/reserved_words.dart';

import '../../../../core/errors/file_exists_error.dart';

class GenerateUsecases implements IGenerateUsecases {
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

    var completePathI = ReservedWords.replaceWordsInFile(
      fileString:
          '$path/${getPathInterface()}/${getNameFileInterface(name, current)}.dart',
      name: name,
      current: current,
    );

    var completePath = ReservedWords.replaceWordsInFile(
      fileString: '$path/${getPath()}/${getNameFile(name, current)}.dart',
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
        fileString: GenerateUsecaseFile.readInterface(name),
        name: name,
        path: path,
        current: current,
      ),
    );

    File(completePath).writeAsStringSync(
      ReservedWords.replaceWordsInFile(
        fileString: GenerateUsecaseFile.readImp(name),
        name: name,
        path: path,
        current: current,
      ),
    );

    applyReplaceIfNecessary(
      current: current,
      name: name,
      path: path,
      subPath: ConfigsFile.getUsecasePath(),
      prefixNameReplaceFile: 'usecase',
    );
    return true;
  }

  @override
  String getNameClass(String name, String current) {
    return ReservedWords.replaceWordsInFile(
      fileString: ConfigsFile.getUsecaseNameClass(),
      name: name,
      current: current,
    );
  }

  @override
  String getNameClassInterface(String name, String current) {
    return ReservedWords.replaceWordsInFile(
      fileString: ConfigsFile.getUsecaseNameClassInterface(),
      name: name,
      current: current,
    );
  }

  @override
  String getNameFile(String name, String current) {
    return ReservedWords.replaceWordsInFile(
      fileString: ConfigsFile.getUsecaseNameFile(),
      name: name,
      current: current,
    );
  }

  @override
  String getNameFileInterface(String name, String current) {
    return ReservedWords.replaceWordsInFile(
      fileString: ConfigsFile.getUsecaseNameFileInterface(),
      name: name,
      current: current,
    );
  }

  @override
  String getPath() {
    return ConfigsFile.getUsecasePath();
  }

  @override
  String getPathInterface() {
    return (ConfigsFile.getUsecasePathInterface());
  }
}
