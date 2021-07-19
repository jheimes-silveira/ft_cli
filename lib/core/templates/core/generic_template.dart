import 'dart:io';

import 'package:recase/recase.dart';

import '../../utils/file_configs.dart';

String layerTemplateInterface(String nameClass) {
  var output = '''
abstract class ${ReCase(nameClass).pascalCase} {
  Future<void> call();
}
  ''';

  return output;
}

String layerTemplate({
  required String nameClass,
  required String nameClassInterface,
  required String nameFile,
  required String nameFileInterface,
  String pathInterface = '',
  String path = '',
}) {
  if (path.isNotEmpty && path.split('/').isNotEmpty) {
    path.split('/').forEach((e) {
      pathInterface = '../' + pathInterface;
    });
  }

  var integration = FileConfigs.getIntegration();

  if (integration == 'flutter_modular') {
    return '''
import '$pathInterface/${ReCase(nameFileInterface).originalText}.dart';
import 'package:flutter_modular/flutter_modular.dart';

part '$nameFile.g.dart';

@Injectable()
class ${ReCase(nameClass).pascalCase} implements ${ReCase(nameClassInterface).pascalCase} {
  @override
  Future<void> call() {
    // TODO: implement call
    throw UnimplementedError();
  }
}
  ''';
  }

  return '''
import '$pathInterface/${ReCase(nameFileInterface).originalText}.dart';

class ${ReCase(nameClass).pascalCase} implements ${ReCase(nameClassInterface).pascalCase} {
  @override
  Future<void> call() {
    // TODO: implement call
    throw UnimplementedError();
  }
}
  ''';
}

void updateIntegrationModule(
  String path,
  String paramsName,
  String subPathImport,
) {
  final integration = FileConfigs.getIntegration();
  if (integration == 'flutter_modular') {
    final fileName = path + '\\' + path.split('\\').last + '_module.dart';

    if (File(fileName).existsSync()) {
      var lines = File(fileName).readAsStringSync();

      lines = lines.replaceFirst('final List<Bind> binds = [',
          'final List<Bind> binds = [\n\t\t\$$paramsName,');

      lines = lines.replaceFirst(
          "import 'package:flutter_modular/flutter_modular.dart';",
          "import 'package:flutter_modular/flutter_modular.dart';\nimport '$subPathImport/${ReCase(paramsName).snakeCase}.dart';");

      File(fileName).writeAsStringSync(lines);
    }
  }
}
