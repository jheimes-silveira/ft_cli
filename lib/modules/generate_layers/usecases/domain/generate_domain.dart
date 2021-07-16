import 'dart:io';

import '../../../../core/interfaces/igenerate_layers.dart';

class GenerateDomain implements IGenerateLayers {
  @override
  Future<bool> call(String path) async {
    var isValidDirectory = await Directory(path).exists();

    if (isValidDirectory) {
      var dir = await Directory('$path/domain').create();

      await Directory('${dir.path}/entities').create();
      await Directory('${dir.path}/usecases').create();
      await Directory('${dir.path}/repositories').create();
      return true;
    } else {
      return false;
    }
  }
}
