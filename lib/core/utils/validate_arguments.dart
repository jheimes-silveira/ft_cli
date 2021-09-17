import '../../app_module.dart';
import 'output_utils.dart' as output;

class ValidateArguments {
  final AppModule appModule;

  ValidateArguments({required this.appModule});

  bool validateArguments(List<String> arguments) {
    if (arguments.isEmpty) {
      output.error('No arguments, try with --help or -h');
      return false;
    }

    if ([
          'init',
          'i',
          'upgrade',
          'u',
          'version',
          'v',
          'help',
          'h',
          'microfrontend',
          'mf',
        ].contains(arguments[0]) &&
        arguments.length == 1) {
      return true;
    }

    if (['gen', 'g'].contains(arguments[0]) &&
        [
          'layer',
          'l',
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
      if (ifContainsExtraArguments(arguments)) {
        if (!extraArgumentsValid(arguments)) {
          return false;
        }
      }

      return true;
    }

    output.error('Invalid command, try with --help or -h');
    return false;
  }

  bool ifContainsExtraArguments(List<String> arguments) {
    return arguments.length > ['g', 'action', 'path', 'name'].length;
  }

  bool extraArgumentsValid(List<String> arguments) {
    if (arguments.length > ['g', 'action', 'path', 'name'].length) {
      for (var i = 4; i < arguments.length; i++) {
        if (!['-u', '-e', '-r', '-d', '-p', '-dto', '-c']
            .contains(arguments[i])) return false;
      }
      return true;
    }

    return false;
  }

  List<String> argumentsExtra(List<String> arguments) {
    return arguments.sublist(['g', 'action', 'path', 'name'].length);
  }
}
