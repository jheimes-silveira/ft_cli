import 'package:js_cli/controller/design_pattern/design_pattern_controller.dart';
import 'package:js_cli/core/utils/constants.dart';
import 'package:js_cli/core/utils/output_utils.dart';
import 'package:js_cli/models/entities/design_pattern/controller_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/datasource_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/datasource_interface_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/page_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/repository_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/repository_interface_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/usecase_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/usecase_interface_design_pattern.dart';
import 'package:js_cli/models/entities/microfrontend/base_app.dart';
import 'package:js_cli/models/entities/microfrontend/micro_commons.dart';
import 'package:js_cli/models/entities/microfrontend/micro_core.dart';
import 'package:js_cli/models/entities/microfrontend/microfrontend.dart';

import 'microfrontend/microfrontend_controller.dart';

class InitController {
  Future<void> call() async {
    _createFileConfig();
    warn('Pasta de configuração .${Constants.projectName} criada');
  }

  void _createFileConfig() {
    _configDesignPattern(RepositoryInterfaceDesignPattern());
    _configDesignPattern(RepositoryDesignPattern());
    _configDesignPattern(DatasourceInterfaceDesignPattern());
    _configDesignPattern(DatasourceDesignPattern());
    _configDesignPattern(UsecaseInterfaceDesignPattern());
    _configDesignPattern(UsecaseDesignPattern());
    _configDesignPattern(PageDesignPattern());
    _configDesignPattern(ControllerDesignPattern());

    _configMicroFrontend(MicroCommons());
    _configMicroFrontend(MicroCore());
    _configMicroFrontend(BaseApp());
    _configMicroFrontend(MicroCommons());
  }

  Future<void> _configDesignPattern(DesignPattern designPattern) async {
    designPattern.nameClass();
    designPattern.nameFile();
    designPattern.path();
    designPattern.template();
    designPattern.nameDesignPattern();

    await DesignPatternController.applyTriggersIfNecessary(designPattern);
  }

  void _configMicroFrontend(Microfrontend microfrontend) async {
    microfrontend.component;
    microfrontend.divider;
    microfrontend.prefix;

    await MicrofrontendController.applyTriggersIfNecessary(microfrontend);
  }
}
