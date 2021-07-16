
import '../../utils/file_configs.dart';
import 'package:recase/recase.dart';

String layerTemplateInterface(String layerName, String layer) {
  var output = '''
abstract class ${ReCase(layerName).pascalCase}${ReCase(layer).pascalCase} {
  Future<void>call();
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
import '$outerLayer${ReCase(layerName).snakeCase}.${ReCase(layer).originalText}.dart';
import 'package:flutter_modular/flutter_modular.dart';

part '${ReCase(layerName).snakeCase}_imp.${ReCase(layer).snakeCase}.g.dart';

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
import '$outerLayer${ReCase(layerName).snakeCase}.${ReCase(layer).originalText}.dart';

class ${ReCase(layerName).pascalCase}Imp${ReCase(layer).pascalCase} implements ${ReCase(layerName).pascalCase}${ReCase(layer).pascalCase} {
  @override
  Future<void> call() {
    // TODO: implement call
    throw UnimplementedError();
  }
}
  ''';
}
