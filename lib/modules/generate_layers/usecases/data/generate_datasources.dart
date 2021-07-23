import 'dart:io';

import 'package:js_cli/core/files/configs_file.dart';
import 'package:js_cli/core/interfaces/igenerate_datasources.dart';
import 'package:js_cli/core/utils/reserved_words.dart';

import '../../../../core/errors/file_exists_error.dart';
import '../../../../core/templates/core/generic_template.dart';

class GenerateDatasources implements IGenerateDatasources {
  @override
  Future<bool> call({
    required String name,
    required String path,
  }) async {
    if (!(Directory(path).existsSync())) return false;

    var completePathI =
        '$path/${getPathInterface()}/${getNameFileInterface(name)}.dart';
    var completePath = '$path/${getPath()}/${getNameFile(name)}.dart';

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
      fileString: ConfigsFile.getDatasourceNameClass(),
      name: name,
    );
  }

  @override
  String getNameClassInterface(String name) {
    return ReservedWords.replaceWordsInFile(
      fileString: ConfigsFile.getDatasourceNameClassInterface(),
      name: name,
    );
  }

  @override
  String getNameFile(String name) {
    return ReservedWords.replaceWordsInFile(
      fileString: ConfigsFile.getDatasourceNameFile(),
      name: name,
    );
  }

  @override
  String getNameFileInterface(String name) {
    return ReservedWords.replaceWordsInFile(
      fileString: ConfigsFile.getDatasourceNameFileInterface(),
      name: name,
    );
  }

  @override
  String getPath() {
    return ConfigsFile.getDatasourcePath();
  }

  @override
  String getPathInterface() {
    return (ConfigsFile.getDatasourcePathInterface());
  }
}
