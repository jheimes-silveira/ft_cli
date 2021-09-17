import 'dart:io';

import 'package:js_cli/core/utils/dialog_utils.dart';
import 'package:js_cli/models/entities/microfrontend/micro_core.dart';

import 'microfrontend_controller.dart';

class MicroCoreController extends MicrofrontendController {
  final MicroCore _microCore;
  MicroCoreController(this._microCore);

  @override
  Future run() {
    final projectName = DialogUtils.newQuestion(
      'Digite o nome do seu ${_microCore.component}\nexemplos: meu_projeto\n(obs): não deve conter espaço em branco\nnome ${_microCore.component}: ',
    );

    stdout.write('\n\n');

    return super.processRun(_microCore, projectName);
  }
}
