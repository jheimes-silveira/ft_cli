import 'dart:io';

import 'package:ft_cli/core/utils/dialog_utils.dart';
import 'package:ft_cli/models/entities/microfrontend/micro_commons.dart';

import 'microfrontend_controller.dart';

class MicroCommonsController extends MicrofrontendController {
  final MicroCommons _microCommons;
  MicroCommonsController(this._microCommons);

  @override
  Future run() {
    final projectName = DialogUtils.newQuestion(
      'Digite o nome do seu ${_microCommons.component}\nexemplos: auth, dependencies, utils, extensions...\n(obs): não deve conter espaço em branco\nnome ${_microCommons.component}: ',
    );
    stdout.write('\n\n');
    return super.processRun(_microCommons, projectName);
  }
}
