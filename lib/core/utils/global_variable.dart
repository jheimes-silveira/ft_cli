class GlobalVariable {
  static String name = '';
  static String path = '';
  static String action = '';
  static String module = '';
  static String projectNameComplete = '';
  static String projectName = '';

  static init(List<String> arguments) {
    GlobalVariable.action = _getFormatAction(arguments);
    try {
      GlobalVariable.path = arguments[2];
      // ignore: empty_catches
    } catch (e) {}
    try {
      GlobalVariable.name = arguments[3];
      // ignore: empty_catches
    } catch (e) {}
  }

  static String _getFormatAction(List<String> arguments) {
    final action = arguments.length > 1 ? arguments[1] : arguments[0];

    if (action == 'i') {
      return 'init';
    } else if (action == 'v') {
      return 'version';
    } else if (action == 'h') {
      return 'help';
    } else if (action == 'l') {
      return 'layer';
    } else if (action == 'mf') {
      return 'microfrontend';
    } else if (action == 'u') {
      return 'usecase';
    } else if (action == 'e') {
      return 'entity';
    } else if (action == 'r') {
      return 'repository';
    } else if (action == 'd') {
      return 'datasource';
    } else if (action == 'p') {
      return 'page';
    } else if (action == 'c') {
      return 'controller';
    }

    return action;
  }
}
