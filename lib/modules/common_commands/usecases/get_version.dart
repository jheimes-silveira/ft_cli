import '../../../core/utils/constants.dart';
import '../../../core/interfaces/iget_version_cli.dart';
import '../../../core/utils/output_utils.dart' as output;

class GetVersionCli implements IGetVersionCli {
  @override
  Future<bool> call() async {
    output.title('CLI at $packageVersion');
    return true;
  }
}
