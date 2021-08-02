import 'dart:io';

import '../../../../core/interfaces/igenerate_layers.dart';

class GeneratePresentation implements IGenerateLayers {
  @override
  Future<bool> call(String path, String current) async {
    var isValidDirectory = await Directory(path).exists();
    if (isValidDirectory) {
      var dir = await Directory('$path/presentation').create();
      await Directory('${dir.path}/controllers').create();
      await Directory('${dir.path}/ui/pages').create(recursive: true);
      await Directory('${dir.path}/ui/widgets').create(recursive: true);
      return true;
    } else {
      return false;
    }
  }
}
