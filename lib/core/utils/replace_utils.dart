import 'dart:io';

import 'package:js_cli/core/files/generate_new_file.dart';
import 'package:js_cli/core/files/generate_replace_file.dart';
import 'package:js_cli/core/model/dtos/new_file_dto.dart';
import 'package:js_cli/core/model/dtos/replace_dto.dart';
import 'package:js_cli/core/utils/output_utils.dart';
import 'package:js_cli/core/utils/reserved_words.dart';

void applyTriggersIfNecessary({
  required String path,
  required String subPath,
  required String prefixNameReplaceFile,
  required String name,
}) {
  final replaces = GenerateReplaceFile.read(subPath, prefixNameReplaceFile);
  final newFiles = GenerateNewFile.read(subPath, prefixNameReplaceFile);

  newFiles.forEach((n) {
    _applyNewFileIfNecessary(n, path, name);
  });

  replaces.forEach((r) {
    _applyReplaceIfNecessary(r, path, name);
  });
}

void _applyReplaceIfNecessary(
  ReplaceDto r,
  String path,
  String name,
) {
  final pathFile = ReservedWords.replaceWordsInFile(
    fileString: r.pathFile,
    name: name,
    path: path,
  );

  if (File(pathFile).existsSync()) {
    final from = ReservedWords.replaceWordsInFile(
      fileString: r.from,
      name: name,
      path: path,
    );
    final to = ReservedWords.replaceWordsInFile(
      fileString: r.to,
      name: name,
      path: path,
    );

    var lines = File(pathFile).readAsStringSync();
    lines = lines.replaceFirst(from, to);
    File(pathFile).writeAsStringSync(lines);
    warn('replace in file $pathFile....');
  }
}

void _applyNewFileIfNecessary(
  NewFileDto newFileDto,
  String path,
  String name,
) {
  if (!newFileDto.generate) return;

  if (newFileDto.pathFile.isEmpty) {
    error('pathFile Empty $path $name');
    return;
  }

  if (newFileDto.extension.isEmpty) {
    error('extension Empty $path $name');
    return;
  }

  final pathFile = ReservedWords.replaceWordsInFile(
    fileString: newFileDto.pathFile,
    name: name,
    path: path,
  );

  if (File('$pathFile.${newFileDto.extension}').existsSync()) {
    error('exist file: $pathFile.${newFileDto.extension}');
    return;
  }

  final exempleFile = File(newFileDto.pathTemplete).readAsStringSync();

  final contentExemple = ReservedWords.replaceWordsInFile(
    fileString: exempleFile,
    name: name,
    path: path,
  );

  if (contentExemple.isEmpty) {
    error('templete empty: ${newFileDto.pathTemplete}');
    return;
  }

  File('$pathFile.${newFileDto.extension}').createSync();
  File('$pathFile.${newFileDto.extension}').writeAsStringSync(contentExemple);
  warn('create file $pathFile ...');
}
