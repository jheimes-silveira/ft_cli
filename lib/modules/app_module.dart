import 'package:args/args.dart';
import 'package:get_it/get_it.dart';
import 'common_commands/common_module.dart';
import 'generate_layers/generate_module.dart';

class AppModule {
  final getIt = GetIt.instance;
  late GenerateModule generate;
  late CommonCommandsModule commandsModule;
  late ArgResults argResults;
  late ArgParser argParser;

  void _addOptionsArguments(ArgParser argParser) {
    argParser.addOption(
      'gen',
      abbr: 'g',
      allowed: ['layer', 'usecase', 'repository', 'datasource', 'entity', 'dto', 'error'],
      help: 'command to generate something',
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
    generate = GenerateModule();
    commandsModule = CommonCommandsModule();
  }

  AppModule() {
    _bootstrap();
  }
}
