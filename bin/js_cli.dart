import 'package:js_cli/core/utils/output_utils.dart';
import 'package:js_cli/core/utils/validate_arguments.dart';
import 'package:js_cli/core/utils/wellcome_message.dart';
import 'package:js_cli/modules/app_module.dart';
import 'package:js_cli/modules/common_commands/controllers/common_commands_controller.dart';
import 'package:js_cli/modules/generate_layers/controllers/generate_domain_controller.dart';
import 'package:js_cli/modules/generate_layers/controllers/generate_layer_controller.dart';

late AppModule appModule;
late ValidateArguments validateArguments;

void main(List<String> arguments) {
  wellcomeMessage();

  appModule = AppModule();
  validateArguments = ValidateArguments(appModule: appModule);

  var isValidArguments = validateArguments.validateArguments(arguments);
  if (isValidArguments == 'not valid arguments') {
    return;
  }

  var generateLayerController =
      appModule.generate.getIt<GenerateLayerController>();
  var generateDomainController =
      appModule.generate.getIt<GenerateDomainController>();

  var commomCommandsController =
      appModule.commandsModule.getIt<CommomCommandsController>();

  if (isValidArguments != 'not valid arguments') {
    switch (isValidArguments) {
      case 'version':
        commomCommandsController.getVersionCli();
        break;
      case 'help':
        commomCommandsController.getHelpCommand();
        break;
      case 'layer':
        if (arguments.length > 2) {
          generateLayerController.generateLayerFolders(
            layerCommand: arguments[2],
            path: arguments.length == 4 ? arguments[3] : './',
          );
        } else {
          error('Invalid command, try with --help or -h');
        }

        break;
      case 'usecase':
        if (arguments.length > 3) {
          generateDomainController.generateUsecase(
            arguments[3],
            arguments[2],
            isValidArguments,
          );
        } else {
          error('Missing arguments, especific your usecase name');
        }
        break;
      case 'entity':
        if (arguments.length > 3) {
          generateDomainController.generateEntity(
            arguments[3],
            arguments[2],
          );
        } else {
          error('Missing arguments, especific your entity name');
        }
        break;
      case 'repository':
        if (arguments.length > 3) {
          generateDomainController.generateRepository(
            arguments[3],
            arguments[2],
            isValidArguments,
          );
        } else {
          error('Missing arguments, especific your repository name');
        }
        break;
      case 'datasource':
        if (arguments.length > 3) {
          generateDomainController.generateDatasource(
            arguments[3],
            arguments[2],
            isValidArguments,
          );
        } else {
          error('Missing arguments, especific your datasource name');
        }
        break;
      case 'page':
        if (arguments.length > 3) {
          generateDomainController.generatePage(
            arguments[3],
            arguments[2],
            isValidArguments,
          );
        } else {
          error('Missing arguments, especific your datasource name');
        }
        break;
      case 'dto':
        if (arguments.length > 3) {
          generateDomainController.generateDto(
            arguments[3],
            arguments[2],
          );
        } else {
          error('Missing arguments, especific your dto name');
        }
        break;
      case 'error':
        if (arguments.length > 3) {
          generateDomainController.generateError(
            arguments[3],
            arguments[2],
          );
        } else {
          error('Missing arguments, especific your error name');
        }
        break;
    }
  }
}
