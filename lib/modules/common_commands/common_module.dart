import 'package:args/args.dart';
import '../../../core/interfaces/iintegration_command.dart';
import '../../../modules/common_commands/usecases/integration_command.dart';
import 'package:get_it/get_it.dart';

import '../../core/interfaces/iget_version_cli.dart';
import '../../core/interfaces/ihelp_command.dart';
import 'controllers/common_commands_controller.dart';
import 'usecases/get_version.dart';
import 'usecases/help_command.dart';

class CommonCommandsModule {
  final getIt = GetIt.instance;
  void _setup() {
    getIt.registerLazySingleton<IGetVersionCli>(() => GetVersionCli());
    getIt.registerLazySingleton<IHelpCommand>(
      () => HelpCommand(
        getIt.get<ArgParser>(),
      ),
    );
    getIt.registerLazySingleton<IIntegrationCommand>(
      () => IntegrationCommand(),
    );
    getIt.registerLazySingleton<CommomCommandsController>(
      () => CommomCommandsController(
        getIt.get<IGetVersionCli>(),
        getIt.get<IHelpCommand>(),
        getIt.get<IIntegrationCommand>(),
      ),
    );
  }

  CommonCommandsModule() {
    _setup();
  }
}