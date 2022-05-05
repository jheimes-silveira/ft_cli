import 'dart:io';

import 'package:path/path.dart' as p;

String normalize(String path) {
  path = path.replaceAll('/', Platform.pathSeparator);
  path = path.replaceAll('\\', Platform.pathSeparator);
  path = p.normalize(path);
  return path;
}
