import 'package:ft_cli/core/utils/directory_utils.dart';
import 'package:ft_cli/core/utils/global_variable.dart';
import 'package:ft_cli/core/utils/output_utils.dart';
import 'package:ft_cli/core/utils/path.dart';
import 'package:ft_cli/core/utils/reserved_words.dart';
import 'package:ft_cli/core/utils/triggers_utils.dart';
import 'package:ft_cli/models/entities/design_pattern/controller_design_pattern.dart';
import 'package:ft_cli/models/entities/design_pattern/datasource_design_pattern.dart';
import 'package:ft_cli/models/entities/design_pattern/datasource_interface_design_pattern.dart';
import 'package:ft_cli/models/entities/design_pattern/design_pattern.dart';
import 'package:ft_cli/models/entities/design_pattern/page_design_pattern.dart';
import 'package:ft_cli/models/entities/design_pattern/repository_design_pattern.dart';
import 'package:ft_cli/models/entities/design_pattern/repository_interface_design_pattern.dart';
import 'package:ft_cli/models/entities/design_pattern/usecase_design_pattern.dart';
import 'package:ft_cli/models/entities/design_pattern/usecase_interface_design_pattern.dart';

class GenerateLayerController {
  Future<void> call() async {
    _createDirectories();

    await applyTriggersIfNecessary();
  }

  static Future applyTriggersIfNecessary() {
    return TriggersUtils.applyIfNecessary(
      root: 'template',
      subPath: 'layer',
      prefixNameReplaceFile: 'complete',
    );
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

  Future<void> _generateLayer(DesignPattern designPattern) async {
    final path = normalize(
        '${GlobalVariable.path}/${ReservedWords.removeWordsInFile(fileString: designPattern.path())}');

    await DirectoryUtils.create(path);

    warn(
      'Pasta criada: diretório de ${designPattern.nameDesignPattern()} $path',
    );
  }
}
