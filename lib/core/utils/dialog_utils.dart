import 'package:interact/interact.dart';

class DialogUtils {
  static String newQuestion(String question) {
    return Input(
      prompt: question,
      validator: (String x) {
        if (x.isNotEmpty) {
          return true;
        } else {
          throw ValidationError('Nenhuma entrada');
        }
      },
    ).interact();
  }

  static String newChoose(String question, List<String> options) {
    final index = Select(
      prompt: question,
      options: options,
    ).interact();

    return options[index];
  }
}
