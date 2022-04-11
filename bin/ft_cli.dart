import 'dart:io';

import 'package:ft_cli/app_module.dart';
import 'package:ft_cli/controller/design_pattern/design_pattern_controller.dart';
import 'package:ft_cli/controller/generate_layer_controller.dart';
import 'package:ft_cli/controller/get_version_controller.dart';
import 'package:ft_cli/controller/help_command_controller.dart';
import 'package:ft_cli/controller/init_controller.dart';
import 'package:ft_cli/controller/microfrontend/base_app_controller.dart';
import 'package:ft_cli/controller/microfrontend/micro_app_controller.dart';
import 'package:ft_cli/controller/microfrontend/micro_commons_controller.dart';
import 'package:ft_cli/controller/microfrontend/micro_core_controller.dart';
import 'package:ft_cli/controller/microfrontend/microfrontend_controller.dart';
import 'package:ft_cli/core/commands/localization.dart';
import 'package:ft_cli/core/utils/dialog_utils.dart';
import 'package:ft_cli/core/utils/global_variable.dart';
import 'package:ft_cli/core/utils/output_utils.dart';
import 'package:ft_cli/core/utils/validate_arguments.dart';
import 'package:ft_cli/models/entities/design_pattern/controller_design_pattern.dart';
import 'package:ft_cli/models/entities/design_pattern/datasource_design_pattern.dart';
import 'package:ft_cli/models/entities/design_pattern/datasource_interface_design_pattern.dart';
import 'package:ft_cli/models/entities/design_pattern/dto_design_pattern.dart';
import 'package:ft_cli/models/entities/design_pattern/entity_design_pattern.dart';
import 'package:ft_cli/models/entities/design_pattern/page_design_pattern.dart';
import 'package:ft_cli/models/entities/design_pattern/repository_design_pattern.dart';
import 'package:ft_cli/models/entities/design_pattern/repository_interface_design_pattern.dart';
import 'package:ft_cli/models/entities/design_pattern/service_design_pattern.dart';
import 'package:ft_cli/models/entities/design_pattern/service_interface_design_pattern.dart';
import 'package:ft_cli/models/entities/design_pattern/usecase_design_pattern.dart';
import 'package:ft_cli/models/entities/design_pattern/usecase_interface_design_pattern.dart';
import 'package:ft_cli/models/entities/microfrontend/base_app.dart';
import 'package:ft_cli/models/entities/microfrontend/micro_app.dart';
import 'package:ft_cli/models/entities/microfrontend/micro_commons.dart';
import 'package:ft_cli/models/entities/microfrontend/micro_core.dart';

late AppModule appModule;
late InitController _initController;
late ValidateArguments validateArguments;
late GetVersionCliController _getVersionCliController;
late HelpCommandController _helpCommandController;
late GenerateLayerController _generateLayerController;
late Localization _localization;

void main(List<String> arguments) async {
  warn(arguments);
  appModule = AppModule();
  validateArguments = ValidateArguments(appModule: appModule);

  _initController = InitController();
  _getVersionCliController = GetVersionCliController();
  _helpCommandController = HelpCommandController();
  _generateLayerController = GenerateLayerController();
  _localization = Localization();

  var isValidArguments = validateArguments.validateArguments(arguments);
  if (!isValidArguments) {
    error('not valid arguments');
    return;
  }

  await _runProcess(arguments);
}

Future<void> _runProcess(List<String> arguments) async {
  GlobalVariable.init(arguments);

  if (GlobalVariable.action == 'init') {
    await _getInit();
  } else if (GlobalVariable.action == 'i18n') {
    await _generateFileI18n();
  } else if (GlobalVariable.action == 'version') {
    await _getVersion();
  } else if (GlobalVariable.action == 'help') {
    await _getHelp();
  } else if (GlobalVariable.action == 'layer') {
    await _getLayer();
  } else if (GlobalVariable.action == 'microfrontend') {
    await _getMicroFrontend();
  } else if (GlobalVariable.action == 'usecase') {
    await _getUsecase();
  } else if (GlobalVariable.action == 'entity') {
    await _getEntity();
  } else if (GlobalVariable.action == 'repository') {
    await _getRepository();
  } else if (GlobalVariable.action == 'datasource') {
    await _getDatasource();
  } else if (GlobalVariable.action == 'page') {
    await _getPage();
  } else if (GlobalVariable.action == 'dto') {
    await _getDto();
  } else if (GlobalVariable.action == 'controller') {
    await _getController();
  } else if (GlobalVariable.action == 'service') {
    await _getService();
  }

  if (validateArguments.extraArgumentsValid(arguments)) {
    validateArguments.argumentsExtra(arguments).forEach((element) async {
      final path = GlobalVariable.path;
      final name = GlobalVariable.name;

      if (element == '-u') {
        await _runProcess(['g', 'u', path, name]);
      } else if (element == '-e') {
        await _runProcess(['g', 'e', path, name]);
      } else if (element == '-r') {
        await _runProcess(['g', 'r', path, name]);
      } else if (element == '-d') {
        await _runProcess(['g', 'd', path, name]);
      } else if (element == '-p') {
        await _runProcess(['g', 'p', path, name]);
      } else if (element == '-c') {
        await _runProcess(['g', 'c', path, name]);
      } else if (element == '-dto') {
        await _runProcess(['g', 'dto', path, name]);
      } else if (element == '-s') {
        await _runProcess(['g', 's', path, name]);
      }
    });
  }
}

Future _generateFileI18n() async {
  await _localization.run();
}

Future<void> _getInit() async {
  await _initController();
}

Future<void> _getVersion() async {
  await _getVersionCliController();
}

Future<void> _getHelp() async {
  _helpCommandController();
}

Future<void> _getLayer() async {
  await _generateLayerController();
}

Future<void> _getMicroFrontend() async {
  final baseApp = BaseApp();
  final microApp = MicroApp();
  final microCommons = MicroCommons();
  final microCore = MicroCore();

  var options = <String>[
    microApp.component,
    microCommons.component,
    microCore.component,
    baseApp.component,
  ];

  var action = DialogUtils.newChoose(
    'Qual componente você deseja criar?',
    options,
  );

  stdout.write('\n\n');
  late MicrofrontendController controller;

  if (action == microApp.component) {
    controller = MicroAppController(microApp);
  } else if (action == microCommons.component) {
    controller = MicroCommonsController(microCommons);
  } else if (action == microCore.component) {
    controller = MicroCoreController(microCore);
  } else if (action == baseApp.component) {
    controller = BaseAppController(baseApp);
  }

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

Future<void> _getService() async {
  await DesignPatternController.call(
    ServiceDesignPattern(),
  );
  await DesignPatternController.call(
    ServiceInterfaceDesignPattern(),
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
