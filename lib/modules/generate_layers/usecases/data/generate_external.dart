import 'dart:io';

import '../../../../core/interfaces/igenerate_layers.dart';

class GenerateExternal implements IGenerateLayers {
  @override
  Future<bool> call(String path) async {
    var isValidDirectory = await Directory(path).exists();
    if (isValidDirectory) {
      await Directory('$path/external').create();
      await Directory('$path/external/datasources').create();
      return true;
    } else {
      return false;
    }
  }
}
