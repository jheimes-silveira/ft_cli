import 'dart:io';

import 'package:js_cli/core/files/generate_replace_file.dart';
import 'package:js_cli/core/utils/reserved_words.dart';

void applyReplaceIfNecessary({
  required String path,
  required String subPath,
  required String prefixNameReplaceFile,
  required String name,
  required String current,
}) {
  final replaces = GenerateReplaceFile.read(subPath, prefixNameReplaceFile);

  replaces.forEach((r) {
    final pathFile = ReservedWords.replaceWordsInFile(
      fileString: r.pathFile,
      current: current,
      name: name,
      path: path,
    );
   
    if (File(pathFile).existsSync()) {
      final from = ReservedWords.replaceWordsInFile(
        fileString: r.from,
        current: current,
        name: name,
        path: path,
      );
      final to = ReservedWords.replaceWordsInFile(
        fileString: r.to,
        current: current,
        name: name,
        path: path,
      );

      var lines = File(pathFile).readAsStringSync();
      lines = lines.replaceFirst(from, to);
      File(pathFile).writeAsStringSync(lines);
    }
  });
}
