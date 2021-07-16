
import 'package:cli_dialog/cli_dialog.dart';
import '../../../core/interfaces/iintegration_command.dart';
import '../../../core/utils/file_configs.dart';

class IntegrationCommand implements IIntegrationCommand {
  IntegrationCommand();
  @override
  void call() async {
    const listQuestions = [
      [
        {
          'question': 'Integration with some external lib?',
          'options': ['flutter_modular', 'none']
        },
        'integration'
      ]
    ];

    final dialog = CLI_Dialog(listQuestions: listQuestions);
    final answer = dialog.ask();
    final integration = answer['integration'];

    var configs = FileConfigs.read();

    configs['integration'] = integration;
    
    FileConfigs.write(configs);
  }
}
