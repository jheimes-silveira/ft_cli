import 'dart:io';

import 'package:ft_cli/core/errors/file_exists_error.dart';
import 'package:ft_cli/core/utils/directory_utils.dart';
import 'package:ft_cli/core/utils/global_variable.dart';
import 'package:ft_cli/core/utils/output_utils.dart';
import 'package:ft_cli/core/utils/reserved_words.dart';
import 'package:ft_cli/core/utils/triggers_utils.dart';
import 'package:ft_cli/models/entities/design_pattern/design_pattern.dart';
import 'package:ft_cli/core/utils/path.dart' as p;

class DesignPatternController {
  static Future<bool> call(
    DesignPattern designPattern,
  ) async {
    var path = _replaceWordsInFile(
      designPattern.path(),
    );
    var nameFile = _replaceWordsInFile(
      designPattern.nameFile(),
    );
    var templete = _replaceWordsInFile(
      designPattern.template(),
    );
    var extension = designPattern.extension();

    var completePath = p.normalize(
      '${GlobalVariable.path}/$path/$nameFile.$extension',
    );

    await DirectoryUtils.create(
      p.normalize(GlobalVariable.path + '/' + path),
    );

    if (File(completePath).existsSync()) {
      error('exist file: $nameFile.$extension....');
      throw FileExistsError(innerException: Exception());
    }

    warn('generating $nameFile.$extension....');

    File(completePath).writeAsStringSync(templete);
    warn('create file $completePath....');

    await applyTriggersIfNecessary(designPattern);

    return true;
  }

  static Future applyTriggersIfNecessary(DesignPattern designPattern) {
    return TriggersUtils.applyIfNecessary(
      root: 'template',
      subPath: designPattern.path(),
      prefixNameReplaceFile: designPattern.nameDesignPattern(),
    );
  }

  static String _replaceWordsInFile(String file) {
    return ReservedWords.replaceWordsInFile(
      fileString: file,
    );
  }
}
