import 'package:js_cli/app/domain/models/entities/controller_design_pattern.dart';
import 'package:js_cli/app/domain/models/entities/datasource_design_pattern.dart';
import 'package:js_cli/app/domain/models/entities/datasource_interface_design_pattern.dart';
import 'package:js_cli/app/domain/models/entities/dto_design_pattern.dart';
import 'package:js_cli/app/domain/models/entities/entity_design_pattern.dart';
import 'package:js_cli/app/domain/models/entities/page_design_pattern.dart';
import 'package:js_cli/app/domain/models/entities/repository_design_pattern.dart';
import 'package:js_cli/app/domain/models/entities/repository_interface_design_pattern.dart';
import 'package:js_cli/app/domain/models/entities/usecase_design_pattern.dart';
import 'package:js_cli/app/domain/models/entities/usecase_interface_design_pattern.dart';
import 'package:js_cli/app/domain/models/factories/design_pattern_factory.dart';
import 'package:js_cli/core/utils/output_utils.dart';
import 'package:js_cli/core/utils/validate_arguments.dart';
import 'package:js_cli/core/utils/wellcome_message.dart';
import 'package:js_cli/modules/app_module.dart';
import 'package:js_cli/modules/common_commands/controllers/common_commands_controller.dart';
import 'package:js_cli/modules/generate_layers/controllers/generate_domain_controller.dart';
import 'package:js_cli/modules/generate_layers/controllers/generate_layer_controller.dart';
import 'package:process_run/cmd_run.dart';

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
  var term = arguments.length > 1 ? arguments[1] : arguments[0];

  final actions = {
    'version': () => _getVersion(),
    'v': () => _getVersion(),
    'help': () => _getHelp(),
    'h': () => _getHelp(),
    'layer': () => _getLayer(arguments),
    'l': () => _getLayer(arguments),
    'micro_app': () => _getMicroApp(arguments),
    'usecase': () => _getUsecase(arguments),
    'u': () => _getUsecase(arguments),
    'entity': () => _getEntity(arguments),
    'e': () => _getEntity(arguments),
    'repository': () => _getRepository(arguments),
    'r': () => _getRepository(arguments),
    'datasource': () => _getDatasource(arguments),
    'd': () => _getDatasource(arguments),
    'page': () => _getPage(arguments),
    'p': () => _getPage(arguments),
    'dto': () => _getDto(arguments),
    'error': () => _getError(arguments),
    'controller': () => _getController(arguments),
    'c': () => _getController(arguments),
  };
  try {
    await actions[term]!();
  } catch (e) {
    error(e);
  }

  if (validateArguments.ifItContainsExtraArgumentsTheyAreValid(arguments)) {
    validateArguments.argumentsExtra(arguments).forEach((element) async {
      final actions = {
        '-u': () => _runProcess(['g', 'u', arguments[2], arguments[3]]),
        '-e': () => _runProcess(['g', 'e', arguments[2], arguments[3]]),
        '-r': () => _runProcess(['g', 'r', arguments[2], arguments[3]]),
        '-d': () => _runProcess(['g', 'd', arguments[2], arguments[3]]),
        '-p': () => _runProcess(['g', 'p', arguments[2], arguments[3]]),
        '-dto': () => _runProcess(['g', 'dto', arguments[2], arguments[3]]),
        '-c': () => _runProcess(['g', 'c', arguments[2], arguments[3]]),
      };
      try {
        await actions[element]!();
      } catch (e) {
        error(e);
      }
    });
  }
}

Future<void> _getVersion() async {
  var commomCommandsController =
      appModule.commandsModule.getIt<CommomCommandsController>();
  await commomCommandsController.getVersionCli();
}

Future<void> _getHelp() async {
  var commomCommandsController =
      appModule.commandsModule.getIt<CommomCommandsController>();
  commomCommandsController.getHelpCommand();
}

Future<void> _getLayer(List<String> arguments) async {
  var generateLayerController =
      appModule.generate.getIt<GenerateLayerController>();
  await generateLayerController.generateLayerFolders(
    layerCommand: arguments[2],
    path: arguments.length == 4 ? arguments[3] : './',
    current: arguments[1],
  );
}

Future<void> _getMicroApp(List<String> arguments) async {
  'g micro_app ';
  await runCmd(
    ProcessCmd(
      'flutter create --template=package teste_ab/flut_micro_core_meu_projeto',
      [],
    ),
  );
}

Future<void> _getUsecase(List<String> arguments) async {
  await DesignPatternFactory.call(
    arguments[3],
    arguments[2],
    UsecaseDesignPattern(),
  );
  await DesignPatternFactory.call(
    arguments[3],
    arguments[2],
    UsecaseInterfaceDesignPattern(),
  );
}

Future<void> _getEntity(List<String> arguments) async {
  await DesignPatternFactory.call(
    arguments[3],
    arguments[2],
    EntityDesignPattern(),
  );
}

Future<void> _getRepository(List<String> arguments) async {
  await DesignPatternFactory.call(
    arguments[3],
    arguments[2],
    RepositoryDesignPattern(),
  );
  await DesignPatternFactory.call(
    arguments[3],
    arguments[2],
    RepositoryInterfaceDesignPattern(),
  );
}

Future<void> _getDatasource(List<String> arguments) async {
  await DesignPatternFactory.call(
    arguments[3],
    arguments[2],
    DatasourceDesignPattern(),
  );
  await DesignPatternFactory.call(
    arguments[3],
    arguments[2],
    DatasourceInterfaceDesignPattern(),
  );
}

Future<void> _getPage(List<String> arguments) async {
  await DesignPatternFactory.call(
    arguments[3],
    arguments[2],
    PageDesignPattern(),
  );
  await DesignPatternFactory.call(
    arguments[3],
    arguments[2],
    ControllerDesignPattern(),
  );
}

Future<void> _getDto(List<String> arguments) async {
  await DesignPatternFactory.call(
    arguments[3],
    arguments[2],
    DtoDesignPattern(),
  );
}

Future<void> _getError(List<String> arguments) async {
  var generateDomainController =
      appModule.generate.getIt<GenerateDomainController>();
  await generateDomainController.generateError(
    arguments[3],
    arguments[2],
  );
}

Future<void> _getController(List<String> arguments) async {
  await DesignPatternFactory.call(
    arguments[3],
    arguments[2],
    ControllerDesignPattern(),
  );
}
