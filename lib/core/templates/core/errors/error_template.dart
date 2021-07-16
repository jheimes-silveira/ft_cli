import 'package:recase/recase.dart';

String errorTemplate(String errorName) {
  var output = '''

class ${ReCase(errorName).pascalCase}Error implements Exception {
  final String _message;
  final Exception innerException;

  ${ReCase(errorName).pascalCase}Error(String message, this.innerException) : _message = message;

  String get message => _message;
}
  ''';

  return output;
}
