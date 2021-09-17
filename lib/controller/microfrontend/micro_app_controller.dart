import 'dart:io';

import 'package:js_cli/core/utils/dialog_utils.dart';
import 'package:js_cli/models/entities/microfrontend/micro_app.dart';

import 'microfrontend_controller.dart';

class MicroAppController extends MicrofrontendController {
  final MicroApp _microApp;
  MicroAppController(this._microApp);

  @override
  Future run() {
    final projectName = DialogUtils.newQuestion(
      'Digite o nome do seu ${_microApp.component}, exemplo meu_novo_app\n(obs): não deve conter espaço em branco\nnome ${_microApp.component}: ',
    );
    stdout.write('\n\n');
    return super.processRun(_microApp, projectName);
  }
}
