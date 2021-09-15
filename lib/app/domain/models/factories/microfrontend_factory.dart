import 'dart:io';

import 'package:js_cli/core/errors/file_exists_error.dart';
import 'package:js_cli/core/utils/directory_utils.dart';
import 'package:js_cli/core/utils/output_utils.dart';
import 'package:js_cli/core/utils/replace_utils.dart';
import 'package:js_cli/core/utils/reserved_words.dart';
import 'package:js_cli/app/domain/models/entities/design_pattern.dart';
import 'package:path/path.dart' as p;

class MicrofrontendFactory {
  static Future<bool> call(
    String inputName,
    String inputPath,
    DesignPattern designPattern,
  ) async {
    var path = _replaceWordsInFile(
      inputName,
      designPattern.path(),
      designPattern.nameDesignPattern(),
    );
    var nameFile = _replaceWordsInFile(
      inputName,
      designPattern.nameFile(),
      designPattern.nameDesignPattern(),
    );
    var templete = _replaceWordsInFile(
      inputName,
      designPattern.template(),
      designPattern.nameDesignPattern(),
    );
    var extension = designPattern.extension();

    var completePath = p.normalize(
      '$inputPath/$path/$nameFile.$extension',
    );

    DirectoryUtils.create(
      p.normalize(inputPath + '/' + path),
    );

    if (File(completePath).existsSync()) {
      error('exist file: $nameFile.$extension....');
      throw FileExistsError(innerException: Exception());
    }

    warn('generating $nameFile.$extension....');

    File(completePath).writeAsStringSync(templete);
    warn('create file $completePath....');

    applyTriggersIfNecessary(
      name: inputName,
      path: inputPath,
      subPath: designPattern.path(),
      prefixNameReplaceFile: designPattern.nameDesignPattern(),
    );

    return true;
  }

  static String _replaceWordsInFile(
      String inputName, String file, String current) {
    return ReservedWords.replaceWordsInFile(
      fileString: file,
      name: inputName,
    );
  }
}
