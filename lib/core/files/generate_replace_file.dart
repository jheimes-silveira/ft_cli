import 'dart:convert';
import 'dart:io';

import 'package:js_cli/core/model/dtos/replace_dto.dart';
import 'package:js_cli/core/utils/directory_utils.dart';
import 'package:js_cli/core/utils/reserved_words.dart';

class GenerateReplaceFile {
  static List<ReplaceDto> read(
    String path,
    String prefixNameReplaceFile,
  ) {
    final file = '${prefixNameReplaceFile}_replace_trigger.json';
    var root = '.js_cli';

    path = ReservedWords.removeWordsInFile(
      fileString: 'template/$path',
    );

    var existFile = File('$root/$path/$file').existsSync();

    if (!existFile) {
      DirectoryUtils.create(root, path);
      File('$root/$path/$file').writeAsStringSync(
        json.encode(
          [
            ReplaceDto('', '', '').toJson(),
          ],
        ),
      );
    }

    return (json.decode(File('$root/$path/$file').readAsStringSync()) as List)
        .map((e) => ReplaceDto.fromJson(e))
        .toList();
  }
}
