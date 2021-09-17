import '../../../core/utils/constants.dart';
import '../../../core/utils/output_utils.dart' as output;

class GetVersionCliController {
  Future<bool> call() async {
    output.title('CLI at $packageVersion');
    return true;
  }
}
