import 'dart:io';

import 'package:ft_cli/core/files/generate_new_file.dart';
import 'package:ft_cli/core/files/generate_replace_file.dart';
import 'package:ft_cli/core/files/generate_scripts.dart';
import 'package:ft_cli/core/utils/directory_utils.dart';
import 'package:ft_cli/core/utils/output_utils.dart';
import 'package:ft_cli/core/utils/path.dart';
import 'package:ft_cli/core/utils/reserved_words.dart';
import 'package:ft_cli/models/dtos/new_file_dto.dart';
import 'package:ft_cli/models/dtos/replace_dto.dart';
import 'package:process_run/shell.dart';

import 'global_variable.dart';

class TriggersUtils {
  TriggersUtils._();

  static Future applyIfNecessary({
    required String root,
    required String subPath,
    required String prefixNameReplaceFile,
    bool isReplaceFiles = true,
    bool isNewFiles = true,
    bool isScripts = false,
  }) async {
    if (isScripts) {
      _initTriggerScripts(root, subPath, prefixNameReplaceFile);
    }
    if (isNewFiles) {
      _initTriggerNewFile(root, subPath, prefixNameReplaceFile);
    }
    if (isReplaceFiles) {
      _initTriggerReplace(root, subPath, prefixNameReplaceFile);
    }
    return;
  }

  static void _initTriggerNewFile(
    String root,
    String subPath,
    String prefixNameReplaceFile,
  ) {
    final newFiles = GenerateNewFile.read(
      root,
      subPath,
      prefixNameReplaceFile,
    );

    for (var n in newFiles) {
      _applyNewFileIfNecessary(n);
    }
  }

  static void _initTriggerReplace(
    String root,
    String subPath,
    String prefixNameReplaceFile,
  ) {
    final replaces = GenerateReplaceFile.read(
      root,
      subPath,
      prefixNameReplaceFile,
    );

    for (var r in replaces) {
      _applyReplaceIfNecessary(r);
    }
  }

  static void _initTriggerScripts(
    String root,
    String subPath,
    String prefixNameReplaceFile,
  ) {
    final scripts = GenerateScripts.read(
      root,
      subPath,
      prefixNameReplaceFile,
    );

    for (var script in scripts) {
      _applyScriptsIfNecessary(script);
    }
  }

  static void _applyReplaceIfNecessary(ReplaceDto r) {
    final pathFile = normalize(ReservedWords.replaceWordsInFile(
      fileString: r.pathFile,
    ));

    if (File(pathFile).existsSync()) {
      final from = ReservedWords.replaceWordsInFile(
        fileString: r.from,
      );
      final to = ReservedWords.replaceWordsInFile(
        fileString: r.to,
      );

      var lines = File(pathFile).readAsStringSync();
      lines = lines.replaceFirst(from, to);
      File(pathFile).writeAsStringSync(lines);
      warn('replace em arquivo $pathFile....\nde: ${r.from}\npara:${r.to}');
    }
  }

  static Future _applyNewFileIfNecessary(
    NewFileDto newFileDto,
  ) async {
    if (!newFileDto.generate) return;

    if (newFileDto.pathFile.isEmpty) {
      error(
        'Variavel pathFile em ${GlobalVariable.path} ${GlobalVariable.name} vazia',
      );
      return;
    }

    if (newFileDto.extension.isEmpty) {
      error('extenção vazia ${GlobalVariable.path} ${GlobalVariable.name}');
      return;
    }

    final pathFile = normalize(ReservedWords.replaceWordsInFile(
      fileString: newFileDto.pathFile,
    ));

    if (!newFileDto.replaceOldFileWithNew) {
      if (File('$pathFile.${newFileDto.extension}').existsSync()) {
        error('Arquivo já existe: $pathFile.${newFileDto.extension}');
        return;
      }
    }

    final exempleFile = File(newFileDto.pathTemplete).readAsStringSync();

    final contentExemple = ReservedWords.replaceWordsInFile(
      fileString: exempleFile,
    );

    if (contentExemple.isEmpty) {
      error('templete vazio: ${newFileDto.pathTemplete}');
      return;
    }

    await DirectoryUtils.create(_pathFolder(pathFile));

    File('$pathFile.${newFileDto.extension}').createSync();
    File('$pathFile.${newFileDto.extension}').writeAsStringSync(contentExemple);
  }

  static Future _applyScriptsIfNecessary(
    String script,
  ) async {
    final shell = Shell();

    script = ReservedWords.replaceWordsInFile(
      fileString: script,
    );

    await shell.run(script);
  }

  static String _pathFolder(String pathFile) {
    pathFile = pathFile.replaceAll('/', Platform.pathSeparator);
    pathFile = pathFile.replaceAll('\\', Platform.pathSeparator);
    
    return pathFile
        .split(Platform.pathSeparator)
        .sublist(0, pathFile.split(Platform.pathSeparator).length - 1)
        .join(Platform.pathSeparator);
  }
}
