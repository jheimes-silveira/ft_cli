import 'dart:io';

import 'package:js_cli/core/utils/dialog_utils.dart';
import 'package:js_cli/models/entities/microfrontend/base_app.dart';

import 'microfrontend_controller.dart';

class BaseAppController extends MicrofrontendController {
  final BaseApp _baseApp;
  BaseAppController(this._baseApp);

  @override
  Future run() {
    final projectName = DialogUtils.newQuestion(
      'Digite o nome do seu ${_baseApp.component}, exemplo meu_novo_projeto\n(obs): não deve conter espaço em branco\nnome ${_baseApp.component}: ',
    );
    stdout.write('\n\n');
    final org = DialogUtils.newQuestion(
      'Para criar o seu ${_baseApp.component} você precisa entrar com um package onde será usado no android o applicationId e no iOS bundleId\nExemplo de package: com.exemplo.empresa.nome_projeto\ndigite o package: ',
    );
    stdout.write('\n\n');
    return super.processRun(_baseApp, projectName, org: org);
  }
}
