import 'package:args/args.dart';
import '../../../core/interfaces/ihelp_command.dart';
import '../../../core/utils/output_utils.dart' as output;

class HelpCommand implements IHelpCommand {
  final ArgParser argParser;

  HelpCommand(this.argParser);
  @override
  void call() {
    output.warn(
      '''
-------------------------- HELPS -------------------------- 
${argParser.usage}
''',
    );
  }
}
