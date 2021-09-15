import 'dart:io';

import 'package:js_cli/core/utils/directory_utils.dart';
import 'package:js_cli/core/utils/replace_utils.dart';
import 'package:js_cli/core/utils/reserved_words.dart';
import 'package:js_cli/app/domain/models/entities/controller_design_pattern.dart';
import 'package:js_cli/app/domain/models/entities/datasource_design_pattern.dart';
import 'package:js_cli/app/domain/models/entities/datasource_interface_design_pattern.dart';
import 'package:js_cli/app/domain/models/entities/page_design_pattern.dart';
import 'package:js_cli/app/domain/models/entities/repository_design_pattern.dart';
import 'package:js_cli/app/domain/models/entities/repository_interface_design_pattern.dart';
import 'package:js_cli/app/domain/models/entities/usecase_design_pattern.dart';
import 'package:js_cli/app/domain/models/entities/usecase_interface_design_pattern.dart';
import 'package:path/path.dart';

import '../../../core/interfaces/igenerate_layers.dart';

class GenerateComplete implements IGenerateLayers {
  @override
  Future<bool> call(String path, String current) async {
    var isValidDirectory = await Directory(path).exists();
    if (!isValidDirectory) await Directory(path).create(recursive: true);

    _createDirectories(path);

    applyTriggersIfNecessary(
      name: '',
      path: path,
      subPath: 'layer',
      prefixNameReplaceFile: 'complete',
    );

    return true;
  }

  void _createDirectories(String path) {
    DirectoryUtils.create(
      normalize(path +
          '/' +
          ReservedWords.removeWordsInFile(
            fileString: RepositoryInterfaceDesignPattern().path(),
          )),
    );
    DirectoryUtils.create(
      normalize(path +
          '/' +
          ReservedWords.removeWordsInFile(
            fileString: RepositoryDesignPattern().path(),
          )),
    );
    DirectoryUtils.create(
      normalize(path +
          '/' +
          ReservedWords.removeWordsInFile(
            fileString: DatasourceInterfaceDesignPattern().path(),
          )),
    );
    DirectoryUtils.create(
      normalize(path +
          '/' +
          ReservedWords.removeWordsInFile(
            fileString: DatasourceDesignPattern().path(),
          )),
    );
    DirectoryUtils.create(
      normalize(path +
          '/' +
          ReservedWords.removeWordsInFile(
            fileString: UsecaseInterfaceDesignPattern().path(),
          )),
    );
    DirectoryUtils.create(
      normalize(path +
          '/' +
          ReservedWords.removeWordsInFile(
            fileString: UsecaseDesignPattern().path(),
          )),
    );
    DirectoryUtils.create(
      normalize(path +
          '/' +
          ReservedWords.removeWordsInFile(
            fileString: PageDesignPattern().path(),
          )),
    );
    DirectoryUtils.create(
      normalize(path +
          '/' +
          ReservedWords.removeWordsInFile(
            fileString: ControllerDesignPattern().path(),
          )),
    );
  }
}
