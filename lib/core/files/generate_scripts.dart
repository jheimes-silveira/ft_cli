import 'dart:convert';
import 'dart:io';

import 'package:ft_cli/core/utils/directory_utils.dart';
import 'package:ft_cli/core/utils/reserved_words.dart';
import 'package:path/path.dart';

class GenerateScripts {
  static List<String> read(
    String group,
    String path,
    String prefixNameReplaceFile,
  ) {
    final file = '${prefixNameReplaceFile}_scripts_trigger.json';
    var root = '.ft_cli';

    path = normalize(ReservedWords.removeWordsInFile(
      fileString: '$group/$path',
    ));

    var existFile = File('$root/$path/$file').existsSync();

    if (!existFile) {
      DirectoryUtils.create(root + '/' + path);

      File('$root/$path/$file').writeAsStringSync(json.encode([]));
    }

    return (json.decode(
      File('$root/$path/$file').readAsStringSync(),
    ) as List)
        .map((e) => e.toString())
        .toList();
  }
}
