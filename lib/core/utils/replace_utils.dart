import 'dart:io';

import 'package:js_cli/core/files/configs_file.dart';
import 'package:js_cli/core/files/generate_new_file.dart';
import 'package:js_cli/core/files/generate_replace_file.dart';
import 'package:js_cli/core/model/dtos/new_file_dto.dart';
import 'package:js_cli/core/model/dtos/replace_dto.dart';
import 'package:js_cli/core/utils/reserved_words.dart';

void applyTriggersIfNecessary({
  required String path,
  required String subPath,
  required String prefixNameReplaceFile,
  required String name,
  required String current,
}) {
  final replaces = GenerateReplaceFile.read(subPath, prefixNameReplaceFile);
  final newFiles = GenerateNewFile.read(subPath, prefixNameReplaceFile);

  replaces.forEach((r) {
    _applyReplaceIfNecessary(r, path, name, current);
  });
  newFiles.forEach((n) {
    _applyNewFileIfNecessary(n, path, name, current);
  });
}

void _applyReplaceIfNecessary(
  ReplaceDto r,
  String path,
  String name,
  String current,
) {
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
}

void _applyNewFileIfNecessary(
  NewFileDto newFileDto,
  String path,
  String name,
  String current,
) {
  if (!newFileDto.generate) return;

  if (newFileDto.pathFile.isEmpty) return;

  final pathFile = ReservedWords.replaceWordsInFile(
    fileString: newFileDto.pathFile,
    current: current,
    name: name,
    path: path,
  );
  final extension = ConfigsFile.getFileExtension();
  if (File('$pathFile.$extension').existsSync()) return;

  final exempleFile = File(newFileDto.pathTemplete).readAsStringSync();

  final contentExemple = ReservedWords.replaceWordsInFile(
    fileString: exempleFile,
    current: current,
    name: name,
    path: path,
  );

  if (contentExemple.isEmpty) return;

  File('$pathFile.$extension').createSync();
  File('$pathFile.$extension').writeAsStringSync(contentExemple);
}
