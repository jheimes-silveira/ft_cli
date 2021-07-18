import 'package:recase/recase.dart';

String entityTemplate(String entityName) {
  var output = '''
class ${ReCase(entityName).pascalCase}Entity {
  ${ReCase(entityName).pascalCase}Entity();
}
  ''';

  return output;
}
