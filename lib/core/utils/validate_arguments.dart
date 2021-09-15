import '../../modules/app_module.dart';
import 'output_utils.dart' as output;

class ValidateArguments {
  final AppModule appModule;

  ValidateArguments({required this.appModule});

  bool validateArguments(List<String> arguments) {
    if (arguments.isEmpty) {
      output.error('No arguments, try with --help or -h');
      return false;
    }

    // appModule.argResults = appModule.argParser.parse(arguments);
    //TODO entender melhor o seu uso

    if (['upgrade', 'u', 'version', 'v', 'help', 'h'].contains(arguments[0]) &&
        arguments.length == 1) {
      return true;
    }

    if (['gen', 'g'].contains(arguments[0]) &&
        [
          'layer',
          'l',
          'base_app',
          'ba',
          'micro_commons',
          'mc',
          'micro_app',
          'mp',
          'usecase',
          'u',
          'entity',
          'e',
          'repository',
          'r',
          'datasource',
          'd',
          'page',
          'p',
          'dto',
          'error',
          'controller',
          'c',
        ].contains(arguments[1])) {
      if (!ifItContainsExtraArgumentsTheyAreValid(arguments)) return false;

      return true;
    }

    output.error('Invalid command, try with --help or -h');
    return false;
  }

  bool ifItContainsExtraArgumentsTheyAreValid(List<String> arguments) {
    if (arguments.length > ['g', 'action', 'path', 'name'].length) {
      for (var i = 4; i < arguments.length; i++) {
        if (!['-u', '-e', '-r', '-d', '-p', '-dto', '-c']
            .contains(arguments[i])) return false;
      }
    }

    return true;
  }

  List<String> argumentsExtra(List<String> arguments) {
    return arguments.sublist(['g', 'action', 'path', 'name'].length);
  }
}
