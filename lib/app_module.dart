import 'package:args/args.dart';
import 'package:get_it/get_it.dart';


class AppModule {
  final getIt = GetIt.instance;
  late ArgResults argResults;
  late ArgParser argParser;

  void _addOptionsArguments(ArgParser argParser) {
    argParser.addOption(
      'gen',
      abbr: 'g',
      allowed: [
        'micro_app',
        'layer',
        'usecase',
        'repository',
        'datasource',
        'entity',
        'dto',
        'error',
        'page',
      ],
      help: 'command to generate something',
    );

    argParser.addOption(
      'layer',
      abbr: 'l',
      help: 'command structure folders',
    );

    argParser.addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'command to show all commands ables',
    );

    argParser.addFlag(
      'version',
      abbr: 'v',
      negatable: false,
      help: 'command to show the current version of the clean-dart-cli',
    );
  }

  void _bootstrap() {
    getIt.registerLazySingleton<ArgParser>(() => ArgParser());
    argParser = getIt.get<ArgParser>();
    _addOptionsArguments(argParser);

  }

  AppModule() {
    _bootstrap();
  }
}
