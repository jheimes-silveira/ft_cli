import '../../../core/interfaces/ihelp_command.dart';
import '../../../core/interfaces/iintegration_command.dart';

import '../../../core/interfaces/iget_version_cli.dart';

class CommomCommandsController {
  final IGetVersionCli _getVersionCli;
  final IHelpCommand _helpCommand;
  final IIntegrationCommand _integrationCommand;

  CommomCommandsController(
    this._getVersionCli,
    this._helpCommand,
    this._integrationCommand,
  );

  Future<void> getVersionCli() => _getVersionCli();

  void getHelpCommand() => _helpCommand();

  void getIntegrationCommand() => _integrationCommand();
}
