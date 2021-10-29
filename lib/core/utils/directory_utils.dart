import 'dart:io';

import 'package:ft_cli/core/utils/path.dart';

class DirectoryUtils {
  static Future create(String path) async {
    
    path = normalize(path);

    if (Directory(path).existsSync()) {
      return;
    }

    var complete = path.split(Platform.pathSeparator)[0];
    final exist = Directory(complete).existsSync();
    if (!exist) Directory(complete).createSync();

    for (var i = 1; i < path.split(Platform.pathSeparator).length; i++) {
      final e = path.split(Platform.pathSeparator)[i];
      if (e.isEmpty) continue;

      complete += '${Platform.pathSeparator}$e';
      final exist = Directory(complete).existsSync();
      if (!exist) Directory(complete).createSync();
    }
  }
}
