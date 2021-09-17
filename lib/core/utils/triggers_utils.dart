import 'dart:io';

import 'package:js_cli/core/files/generate_new_file.dart';
import 'package:js_cli/core/files/generate_replace_file.dart';
import 'package:js_cli/core/files/generate_scripts.dart';
import 'package:js_cli/core/utils/global_variable.dart';
import 'package:js_cli/core/utils/output_utils.dart';
import 'package:js_cli/core/utils/reserved_words.dart';
import 'package:js_cli/models/dtos/new_file_dto.dart';
import 'package:js_cli/models/dtos/replace_dto.dart';
import 'package:process_run/shell.dart';

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

    newFiles.forEach((n) {
      _applyNewFileIfNecessary(n);
    });
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

    replaces.forEach((r) {
      _applyReplaceIfNecessary(r);
    });
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

    scripts.forEach((script) {
      _applyScriptsIfNecessary(script);
    });
  }

  static void _applyReplaceIfNecessary(ReplaceDto r) {
    final pathFile = ReservedWords.replaceWordsInFile(
      fileString: r.pathFile,
    );

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
      warn('replace em arquivo $pathFile....');
    }
  }

  static Future _applyNewFileIfNecessary(NewFileDto newFileDto) async {
    if (!newFileDto.generate) return;

    if (newFileDto.pathFile.isEmpty) {
      final path = GlobalVariable.path;
      final name = GlobalVariable.name;

      error('Variavel pathFile em $path $name vazia');
      return;
    }

    if (newFileDto.extension.isEmpty) {
      final path = GlobalVariable.path;
      final name = GlobalVariable.name;

      error('extenção vazia $path $name');
      return;
    }

    final pathFile = ReservedWords.replaceWordsInFile(
      fileString: newFileDto.pathFile,
    );

    if (File('$pathFile.${newFileDto.extension}').existsSync()) {
      error('Arquivo já existe: $pathFile.${newFileDto.extension}');
      return;
    }

    final exempleFile = File(newFileDto.pathTemplete).readAsStringSync();

    final contentExemple = ReservedWords.replaceWordsInFile(
      fileString: exempleFile,
    );

    if (contentExemple.isEmpty) {
      error('templete vazio: ${newFileDto.pathTemplete}');
      return;
    }

    File('$pathFile.${newFileDto.extension}').createSync();
    File('$pathFile.${newFileDto.extension}').writeAsStringSync(contentExemple);
    warn('Criar arquivo: $pathFile ...');
  }

  static Future _applyScriptsIfNecessary(String script) async {
    final shell = Shell();

    script = ReservedWords.replaceWordsInFile(fileString: script);

    await shell.run(script);
  }
}
