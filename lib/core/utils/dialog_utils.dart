import 'package:cli_dialog/cli_dialog.dart';

class DialogUtils {
  static String newQuestion(String question) {
    final dialog = CLI_Dialog();
    dialog.addQuestion(question, 'name');
    final anwers = dialog.ask();

    return anwers['name'];
  }
}
