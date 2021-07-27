import 'dart:io';

import 'package:js_cli/core/files/configs_file.dart';
import 'package:js_cli/core/files/generate_controller_file.dart';
import 'package:js_cli/core/interfaces/igenerate_controller.dart';
import 'package:js_cli/core/utils/directory_utils.dart';
import 'package:js_cli/core/utils/replace_utils.dart';
import 'package:js_cli/core/utils/reserved_words.dart';

import '../../../../core/errors/file_exists_error.dart';

class GenerateController implements IGenerateController {
  @override
  Future<bool> call({
    required String name,
    required String path,
    required String current,
  }) async {
    DirectoryUtils.create(
      path,
      ReservedWords.replaceWordsInFile(
        fileString: getPath(name, current),
        name: name,
        current: current,
      ),
    );
    final fileExtension = ConfigsFile.getFileExtension();
    var completePath = ReservedWords.replaceWordsInFile(
      fileString:
          '$path/${getPath(name, current)}/${getNameFile(name, current)}.$fileExtension',
      name: name,
      current: current,
    );

    if (File(completePath).existsSync()) {
      throw FileExistsError(innerException: Exception());
    }

    String? content = ReservedWords.replaceWordsInFile(
      fileString: GenerateControllerFile.readImp(name),
      name: name,
      path: path,
      current: current,
    );

    File(completePath).writeAsStringSync(content);

    applyReplaceIfNecessary(
      current: current,
      name: name,
      path: path,
      subPath: ConfigsFile.getControllerPath(),
      prefixNameReplaceFile: 'controller',
    );

    return true;
  }

  @override
  String getNameClass(String name, String current) {
    return ReservedWords.replaceWordsInFile(
      fileString: ConfigsFile.getControllerNameClass(),
      name: name,
      current: current,
    );
  }

  @override
  String getNameFile(String name, String current) {
    return ReservedWords.replaceWordsInFile(
      fileString: ConfigsFile.getControllerNameFile(),
      name: name,
      current: current,
    );
  }

  @override
  String getPath(String name, String current) {
    return ReservedWords.replaceWordsInFile(
      fileString: ConfigsFile.getControllerPath(),
      name: name,
      current: current,
    );
  }
}
