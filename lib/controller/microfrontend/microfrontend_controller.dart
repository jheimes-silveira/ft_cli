import 'package:js_cli/core/utils/global_variable.dart';
import 'package:js_cli/core/utils/triggers_utils.dart';
import 'package:js_cli/models/entities/microfrontend/microfrontend.dart';
import 'package:process_run/shell.dart';

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

    var shell = Shell();
    await shell.run(
      _commandCreateApp(microfrontend, projectName, org),
    );

    return applyTriggersIfNecessary(_microfrontend);
  }

  static Future applyTriggersIfNecessary(Microfrontend microfrontend) {
    return TriggersUtils.applyIfNecessary(
      root: 'microfrontend',
      subPath: microfrontend.component,
      prefixNameReplaceFile: microfrontend.component,
      isScripts: true,
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
