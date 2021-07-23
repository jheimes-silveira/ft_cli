import 'dart:io';

import 'package:js_cli/core/files/configs_file.dart';
import 'package:js_cli/core/files/generate_page_file.dart';
import 'package:js_cli/core/interfaces/igenerate_page.dart';
import 'package:js_cli/core/templates/core/generic_template.dart';
import 'package:js_cli/core/utils/directory_utils.dart';
import 'package:js_cli/core/utils/reserved_words.dart';

import '../../../../core/errors/file_exists_error.dart';

class GeneratePages implements IGeneratePages {
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

    var completePath = ReservedWords.replaceWordsInFile(
      fileString: '$path/${getPath()}/${getNameFile(name)}.dart',
      name: name,
    );

    if (File(completePath).existsSync()) {
      throw FileExistsError(innerException: Exception());
    }

    String? content = ReservedWords.replaceWordsInFile(
      fileString: GeneratePageFile.read(),
      name: name,
      path: path,
    );

    File(completePath).writeAsStringSync(content);

    return true;
  }

  @override
  String getNameClass(String name) {
    return ReservedWords.replaceWordsInFile(
      fileString: ConfigsFile.getPageNameClass(),
      name: name,
    );
  }

  @override
  String getNameFile(String name) {
    return ReservedWords.replaceWordsInFile(
      fileString: ConfigsFile.getPageNameFile(),
      name: name,
    );
  }

  @override
  String getPath() {
    return ConfigsFile.getPagePath();
  }
}
