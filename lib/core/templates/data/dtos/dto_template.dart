import 'package:recase/recase.dart';

String dtoTemplate(String dtoName) {
  var output = '''
import '../../domain/models/entities/${ReCase(dtoName).snakeCase}_entity.dart';

class ${ReCase(dtoName).pascalCase}Dto extends ${ReCase(dtoName).pascalCase}Entity {

  ${ReCase(dtoName).pascalCase}Dto() : super();

}
  ''';

  return output;
}
