import 'package:js_cli/core/utils/global_variable.dart';
import 'package:js_cli/core/utils/output_utils.dart';
import 'package:js_cli/core/utils/triggers_utils.dart';
import 'package:js_cli/models/entities/microfrontend/microfrontend.dart';
import 'package:process_run/cmd_run.dart';

abstract class MicrofrontendController {
  late Microfrontend _microfrontend;
  late String _projectName;

  Future run();

  Future processRun(
    Microfrontend microfrontend,
    String projectName, {
    String? org,
  }) async {
    _microfrontend = microfrontend;
    _projectName = projectName;

    GlobalVariable.projectNameComplete = projectNameComplete;
    GlobalVariable.projectName = projectName;

    final result = await runCmd(
      ProcessCmd(_commandCreateApp(microfrontend, projectName, org), []),
    );

    warn(result.stdout);
    
    return TriggersUtils.applyIfNecessary(
      root: 'microfrontend',
      subPath: _microfrontend.component,
      prefixNameReplaceFile: _microfrontend.component,
    );
  }

  String get projectNameComplete {
    return _microfrontend.projectNameComplete(_projectName);
  }

  String get projectName {
    return _projectName;
  }

  String _commandCreateApp(
    Microfrontend microfrontend,
    String projectName,
    String? org,
  ) {
    var name = microfrontend.projectNameComplete(projectName);

    var command = 'flutter create ';
    if (org == null) {
      command += '--template=package $name';
    } else {
      command += '--org $org $name';
    }

    return command;
  }
}
