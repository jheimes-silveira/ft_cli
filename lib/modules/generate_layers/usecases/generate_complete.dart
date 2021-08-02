import 'dart:io';

import 'package:js_cli/core/files/configs_file.dart';
import 'package:js_cli/core/utils/directory_utils.dart';
import 'package:js_cli/core/utils/replace_utils.dart';
import 'package:js_cli/core/utils/reserved_words.dart';

import '../../../core/interfaces/igenerate_layers.dart';

class GenerateComplete implements IGenerateLayers {
  final IGenerateLayers _gnDomain;
  final IGenerateLayers _gnData;
  final IGenerateLayers _gnPresentation;
  final IGenerateLayers _gnExternal;

  GenerateComplete(
    this._gnDomain,
    this._gnData,
    this._gnPresentation,
    this._gnExternal,
  );

  @override
  Future<bool> call(String path, String current) async {
    var isValidDirectory = await Directory(path).exists();
    if (!isValidDirectory) await Directory(path).create(recursive: true);

    _createDirectories(path);
    // await _gnDomain(path, current);
    // await _gnData(path, current);
    // await _gnPresentation(path, current);
    // await _gnExternal(path, current);

    applyTriggersIfNecessary(
      current: current,
      name: '',
      path: path,
      subPath: 'layer',
      prefixNameReplaceFile: 'complete',
    );

    return true;
  }

  void _createDirectories(String path) {
    DirectoryUtils.create(
      path,
      ReservedWords.removeWordsInFile(
        fileString: ConfigsFile.getRepositoryPathInterface(),
      ),
    );
    DirectoryUtils.create(
      path,
      ReservedWords.removeWordsInFile(
        fileString: ConfigsFile.getRepositoryPath(),
      ),
    );
    DirectoryUtils.create(
      path,
      ReservedWords.removeWordsInFile(
        fileString: ConfigsFile.getDatasourcePathInterface(),
      ),
    );
    DirectoryUtils.create(
      path,
      ReservedWords.removeWordsInFile(
        fileString: ConfigsFile.getDatasourcePath(),
      ),
    );
    DirectoryUtils.create(
      path,
      ReservedWords.removeWordsInFile(
        fileString: ConfigsFile.getUsecasePathInterface(),
      ),
    );
    DirectoryUtils.create(
      path,
      ReservedWords.removeWordsInFile(
        fileString: ConfigsFile.getUsecasePath(),
      ),
    );
    DirectoryUtils.create(
      path,
      ReservedWords.removeWordsInFile(
        fileString: ConfigsFile.getPagePath(),
      ),
    );
    DirectoryUtils.create(
      path,
      ReservedWords.removeWordsInFile(
        fileString: ConfigsFile.getControllerPath(),
      ),
    );
  }
}
