import '../../../core/interfaces/ihelp_command.dart';
import '../../../core/interfaces/iget_version_cli.dart';

class CommomCommandsController {
  final IGetVersionCli _getVersionCli;
  final IHelpCommand _helpCommand;

  CommomCommandsController(
    this._getVersionCli,
    this._helpCommand,
  );

  Future<void> getVersionCli() => _getVersionCli();

  void getHelpCommand() => _helpCommand();
}
