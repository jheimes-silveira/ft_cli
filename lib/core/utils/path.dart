import 'dart:io';

import 'package:path/path.dart' as p;

String normalize(String path) {
  path = path.replaceAll('/', Platform.pathSeparator);
  path = path.replaceAll('\\', Platform.pathSeparator);
  path = p.normalize(path);

  if (path.substring(0, 1) == Platform.pathSeparator) {
    path = path.substring(1, path.length);
  }
  
  return path;
}
