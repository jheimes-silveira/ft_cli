import 'dart:io';

import '../../../../core/interfaces/igenerate_layers.dart';

class GenerateData implements IGenerateLayers {
  @override
  Future<bool> call(String path) async {
    var isValidDirectory = await Directory(path).exists();
    if (isValidDirectory) {
      var dir = await Directory('$path/data').create();
      await Directory('${dir.path}/repositories').create();
      await Directory('${dir.path}/datasources').create();
      await Directory('${dir.path}/dtos').create();
      return true;
    } else {
      return false;
    }
  }
}
