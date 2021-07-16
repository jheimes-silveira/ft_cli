import 'package:recase/recase.dart';

String dtoTemplate(String dtoName) {
  var output = '''
import '../../domain/entities/${ReCase(dtoName).snakeCase}.entity.dart';

class ${ReCase(dtoName).pascalCase}Dto extends ${ReCase(dtoName).pascalCase}Entity {

  ${ReCase(dtoName).pascalCase}Dto() : super();

}
  ''';

  return output;
}
