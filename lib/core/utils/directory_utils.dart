import 'dart:io';

class DirectoryUtils {
  static void create(String root, String path) {
    if (!(Directory(root).existsSync())) {
      throw Exception('directory $root not found');
    }

    var complete = '$root';
    for (var i = 0; i < path.split('/').length; i++) {
      final e = path.split('/')[i];
      if (e.isEmpty) continue;
      complete += '/$e';

      final exist = Directory(complete).existsSync();
      if (!exist) Directory(complete).createSync();
    }
  }
}
