import 'dart:io';

import 'package:js_cli/controller/design_pattern/design_pattern_controller.dart';
import 'package:js_cli/controller/generate_layer_controller.dart';
import 'package:js_cli/controller/get_version_controller.dart';
import 'package:js_cli/controller/help_command_controller.dart';
import 'package:js_cli/controller/microfrontend/base_app_controller.dart';
import 'package:js_cli/controller/microfrontend/micro_app_controller.dart';
import 'package:js_cli/controller/microfrontend/micro_commons_controller.dart';
import 'package:js_cli/controller/microfrontend/micro_core_controller.dart';
import 'package:js_cli/controller/microfrontend/microfrontend_controller.dart';
import 'package:js_cli/core/utils/dialog_utils.dart';
import 'package:js_cli/core/utils/global_variable.dart';
import 'package:js_cli/core/utils/output_utils.dart';
import 'package:js_cli/core/utils/validate_arguments.dart';
import 'package:js_cli/core/utils/wellcome_message.dart';
import 'package:js_cli/models/entities/design_pattern/controller_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/datasource_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/datasource_interface_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/dto_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/entity_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/page_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/repository_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/repository_interface_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/usecase_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/usecase_interface_design_pattern.dart';
import 'package:js_cli/models/entities/microfrontend/base_app.dart';
import 'package:js_cli/models/entities/microfrontend/micro_app.dart';
import 'package:js_cli/models/entities/microfrontend/micro_commons.dart';
import 'package:js_cli/models/entities/microfrontend/micro_core.dart';
import 'package:js_cli/app_module.dart';

late AppModule appModule;
late ValidateArguments validateArguments;

void main(List<String> arguments) async {
  wellcomeMessage();

  appModule = AppModule();
  validateArguments = ValidateArguments(appModule: appModule);

  var isValidArguments = validateArguments.validateArguments(arguments);
  if (!isValidArguments) {
    error('not valid arguments');
    return;
  }

  await _runProcess(arguments);
}

Future<void> _runProcess(List<String> arguments) async {
  _loadGlobalVariables(arguments);

  final actions = {
    'version': () => _getVersion(),
    'v': () => _getVersion(),
    'help': () => _getHelp(),
    'h': () => _getHelp(),
    'layer': () => _getLayer(),
    'l': () => _getLayer(),
    'microfrontend': () => _getMicroFrontend(),
    'mf': () => _getMicroFrontend(),
    'usecase': () => _getUsecase(),
    'u': () => _getUsecase(),
    'entity': () => _getEntity(),
    'e': () => _getEntity(),
    'repository': () => _getRepository(),
    'r': () => _getRepository(),
    'datasource': () => _getDatasource(),
    'd': () => _getDatasource(),
    'page': () => _getPage(),
    'p': () => _getPage(),
    'dto': () => _getDto(),
    'controller': () => _getController(),
    'c': () => _getController(),
  };
  try {
    await actions[GlobalVariable.action]!();
  } catch (e) {
    error(e);
  }

  if (validateArguments.extraArgumentsValid(arguments)) {
    validateArguments.argumentsExtra(arguments).forEach((element) async {
      final path = GlobalVariable.path;
      final name = GlobalVariable.name;
      final actions = {
        '-u': () => _runProcess(['g', 'u', path, name]),
        '-e': () => _runProcess(['g', 'e', path, name]),
        '-r': () => _runProcess(['g', 'r', path, name]),
        '-d': () => _runProcess(['g', 'd', path, name]),
        '-p': () => _runProcess(['g', 'p', path, name]),
        '-c': () => _runProcess(['g', 'c', path, name]),
        '-dto': () => _runProcess(['g', 'dto', path, name]),
      };
      try {
        await actions[element]!();
      } catch (e) {
        error(e);
      }
    });
  }
}

void _loadGlobalVariables(List<String> arguments) {
  GlobalVariable.action = arguments.length > 1 ? arguments[1] : arguments[0];
  try {
    GlobalVariable.path = arguments[2];
    // ignore: empty_catches
  } catch (e) {}
  try {
    GlobalVariable.name = arguments[3];
    // ignore: empty_catches
  } catch (e) {}
}

Future<void> _getVersion() async {
  await GetVersionCliController()();
}

Future<void> _getHelp() async {
  HelpCommandController()();
}

Future<void> _getLayer() async {
  await GenerateLayerController()();
}

Future<void> _getMicroFrontend() async {
  final baseApp = BaseApp();
  final microApp = MicroApp();
  final microCommons = MicroCommons();
  final microCore = MicroCore();

  var action = DialogUtils.newQuestion(
    'Qual componente você deseja criar?\n${microApp.component} (ma)\n${microCommons.component} (ms)\n${microCore.component} (mc)\n${baseApp.component} (ba)\nvocê so pode digitar ma, ms, mc ou ba\nDigite a opção que esta entre conchetes:',
  );

  if (!['ma', 'ms', 'mc', 'ba'].contains(action)) {
    error('Você não pode entrar com valores diferentes de: ma, ms, mc ou ba');
    return;
  }

  stdout.write('\n\n');
  late MicrofrontendController controller;

  if (action == 'ma') controller = MicroAppController(microApp);
  if (action == 'ms') controller = MicroCommonsController(microCommons);
  if (action == 'mc') controller = MicroCoreController(microCore);
  if (action == 'ba') controller = BaseAppController(baseApp);

  await controller.run();
}

String report(answers, {do_print = true}) {
  var output = StringBuffer();
  output.writeln();

  if (do_print) {
    print(answers);
  }
  return output.toString();
}

Future<void> _getUsecase() async {
  await DesignPatternController.call(
    UsecaseDesignPattern(),
  );
  await DesignPatternController.call(
    UsecaseInterfaceDesignPattern(),
  );
}

Future<void> _getEntity() async {
  await DesignPatternController.call(
    EntityDesignPattern(),
  );
}

Future<void> _getRepository() async {
  await DesignPatternController.call(
    RepositoryDesignPattern(),
  );
  await DesignPatternController.call(
    RepositoryInterfaceDesignPattern(),
  );
}

Future<void> _getDatasource() async {
  await DesignPatternController.call(
    DatasourceDesignPattern(),
  );
  await DesignPatternController.call(
    DatasourceInterfaceDesignPattern(),
  );
}

Future<void> _getPage() async {
  await DesignPatternController.call(
    PageDesignPattern(),
  );
  await DesignPatternController.call(
    ControllerDesignPattern(),
  );
}

Future<void> _getDto() async {
  await DesignPatternController.call(
    DtoDesignPattern(),
  );
}

Future<void> _getController() async {
  await DesignPatternController.call(
    ControllerDesignPattern(),
  );
}
