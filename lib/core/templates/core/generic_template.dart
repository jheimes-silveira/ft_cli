import 'dart:io';

import 'package:recase/recase.dart';

import '../../utils/file_configs.dart';

String layerTemplateInterface(String layerName, String layer) {
  var output = '''
abstract class ${ReCase(layerName).pascalCase}${ReCase(layer).pascalCase} {
  Future<void> call();
}
  ''';

  return output;
}

String layerTemplate(
  String layerName,
  String layer, {
  String outerLayer = '',
}) {
  var configs = FileConfigs.read();

  if (configs['integration'] == 'flutter_modular') {
    return '''
import '$outerLayer${ReCase(layerName).snakeCase}_${ReCase(layer).originalText}.dart';
import 'package:flutter_modular/flutter_modular.dart';

part '${ReCase(layerName).snakeCase}_imp_${ReCase(layer).snakeCase}.g.dart';

@Injectable()
class ${ReCase(layerName).pascalCase}Imp${ReCase(layer).pascalCase} implements ${ReCase(layerName).pascalCase}${ReCase(layer).pascalCase} {
  @override
  Future<void> call() {
    // TODO: implement call
    throw UnimplementedError();
  }
}
  ''';
  }

  return '''
import '$outerLayer${ReCase(layerName).snakeCase}_${ReCase(layer).originalText}.dart';

class ${ReCase(layerName).pascalCase}Imp${ReCase(layer).pascalCase} implements ${ReCase(layerName).pascalCase}${ReCase(layer).pascalCase} {
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
  final configs = FileConfigs.read();
  if (configs['integration'] == 'flutter_modular') {
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
