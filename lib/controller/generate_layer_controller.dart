import 'package:js_cli/core/utils/directory_utils.dart';
import 'package:js_cli/core/utils/global_variable.dart';
import 'package:js_cli/core/utils/reserved_words.dart';
import 'package:js_cli/models/entities/design_pattern/controller_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/datasource_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/datasource_interface_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/page_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/repository_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/repository_interface_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/usecase_design_pattern.dart';
import 'package:js_cli/models/entities/design_pattern/usecase_interface_design_pattern.dart';
import 'package:path/path.dart';

class GenerateLayerController {
  Future<void> call() async {
    _createDirectories();
  }

  void _createDirectories() {
    _generateLayer(RepositoryInterfaceDesignPattern());
    _generateLayer(RepositoryDesignPattern());
    _generateLayer(DatasourceInterfaceDesignPattern());
    _generateLayer(DatasourceDesignPattern());
    _generateLayer(UsecaseInterfaceDesignPattern());
    _generateLayer(UsecaseDesignPattern());
    _generateLayer(PageDesignPattern());
    _generateLayer(ControllerDesignPattern());
  }

  void _generateLayer(DesignPattern designPattern) {
    DirectoryUtils.create(
      normalize(
        GlobalVariable.path +
            '/' +
            ReservedWords.removeWordsInFile(
              fileString: designPattern.path(),
            ),
      ),
    );
  }
}
