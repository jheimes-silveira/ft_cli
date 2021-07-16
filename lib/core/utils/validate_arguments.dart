import '../../modules/app_module.dart';
import 'output_utils.dart' as output;

class ValidateArguments {
  final AppModule appModule;

  ValidateArguments({required this.appModule});

  String validateArguments(List<String> arguments) {
    if (arguments.isEmpty) {
      output.error('No arguments, try with --help or -h');
      return 'not valid arguments';
    }

    appModule.argResults = appModule.argParser.parse(arguments);
    if (appModule.argResults.arguments[0] == 'upgrade') {
      return arguments[0];
    }

    if (arguments[0] == 'integration') {
      return 'integration';
    }

    if (appModule.argResults['version']) {
      return 'version';
    }

    if (appModule.argResults['help']) {
      return 'help';
    }
    if (arguments.length < 2) {
      output.error('Invalid command, try with --help or -h');
      return 'not valid arguments';
    }
    var isValidArguments = appModule.argParser.options[arguments[0]]?.allowed
        ?.contains(arguments[1]);

    isValidArguments = appModule.argParser
        .findByAbbreviation(arguments[0])
        ?.allowed
        ?.contains(arguments[1]);

    if (isValidArguments!) {
      return arguments[1];
    } else {
      output.error('Invalid command, try with --help or -h');
      return 'not valid arguments';
    }
  }
}
