import 'package:recase/recase.dart';

String usecaseTemplateInterface(String usecaseName) {
  var output = '''
abstract class ${ReCase(usecaseName).pascalCase}Usecase {
  Future<void>call();
}
  ''';

  return output;
}

String usecaseTemplate(String usecaseName) {
  var output = '''
import '${ReCase(usecaseName).snakeCase}.usecase.dart';

class ${ReCase(usecaseName).pascalCase}ImpUsecase implements ${ReCase(usecaseName).pascalCase}Usecase {
  @override
  Future<void> call() {
    // TODO: implement call
    throw UnimplementedError();
  }
  
}
  ''';

  return output;
}
