import 'package:js_cli/core/files/configs_file.dart';
import 'package:recase/recase.dart';

class ReservedWords {
  ReservedWords._();

  static String removeWordsInFile({required String fileString}) {
    while (fileString.contains('{{')) {
      final start = fileString.indexOf('{{');
      final end = fileString.indexOf('}}');

      String? term = fileString.substring(start + 2, end);

      fileString = fileString.replaceFirst('{{$term}}', '');
    }

    return fileString;
  }

  static String replaceWordsInFile({
    required String fileString,
    required String current,
    String name = '',
    String path = '',
  }) {
    while (fileString.contains('{{')) {
      final start = fileString.indexOf('{{');
      final end = fileString.indexOf('}}');

      String? term = fileString.substring(start + 2, end);
      String? word = term.split('.')[0];
      String? extension;

      if (term.split('.').length > 1) extension = term.split('.')[1];

      if (!_containsWord(word)) {
        throw Exception('essa variavel não é aceita "$word"');
      }

      word = _replaceWordWithOptions(word, name, path, current);

      if (extension != null) {
        word = _recase(word!, extension);

        if (word == null) {
          throw Exception('extenção não aceita "$extension"');
        }
      }

      fileString = fileString.replaceFirst('{{$term}}', word!);
    }

    return fileString;
  }

  static bool _containsWord(String word) {
    return [
      'name',
      'path',
      'module',
      'integration',
      'currentPathInterface',
      'currentNameFileInterface',
      'currentPath',
      'currentNameFile',
      'currentNameClassInterface',
      'currentNameClass',
      'repositoryPathInterface',
      'repositoryNameFileInterface',
      'repositoryPath',
      'repositoryNameFile',
      'repositoryNameClassInterface',
      'repositoryNameClass',
      'datasourcePathInterface',
      'datasourceNameFileInterface',
      'datasourcePath',
      'datasourceNameFile',
      'datasourceNameClassInterface',
      'datasourceNameClass',
      'usecasePathInterface',
      'usecaseNameFileInterface',
      'usecasePath',
      'usecaseNameFile',
      'usecaseNameClassInterface',
      'usecaseNameClass',
      'pagePath',
      'pageNameFile',
      'pageNameClass',
      'controllerPath',
      'controllerNameFile',
      'controllerNameClass',
    ].contains(word);
  }

  static String? _recase(String word, String extension) {
    if (word.contains('{{')) {
      return word;
    } //TDOO implementar algoritimo que aplique o replace em tudo exceto o conteudo dentro dos mustaches {{name.snakeCase}}_controller
    if (word.contains('current')) {
      return word;
    } //TDOO a palavra current deve ser substituida no procimo laço
    if (word.contains('module')) {
      return word;
    } //TDOO a palavra current deve ser substituida no procimo laço
    if (extension == 'camelCase') {
      return word.camelCase; // exemple testeCase
    } else if (extension == 'constantCase') {
      return word.constantCase; // exemple TESTE_CASE
    } else if (extension == 'sentenceCase') {
      return word.sentenceCase; // exemple Teste case
    } else if (extension == 'snakeCase') {
      return word.snakeCase; // exemple teste_case
    } else if (extension == 'dotCase') {
      return word.dotCase; // exemple teste.case
    } else if (extension == 'paramCase') {
      return word.paramCase; // exemple teste-case
    } else if (extension == 'pathCase') {
      return word.pathCase; // exemple teste/case
    } else if (extension == 'pascalCase') {
      return word.pascalCase; // exemple TesteCase
    } else if (extension == 'headerCase') {
      return word.headerCase; // exemple Teste-Case
    } else if (extension == 'titleCase') {
      return word.titleCase; // exemple Teste Case
    } else {
      return null;
    }
  }

  static String? _replaceWordWithOptions(
    String word,
    String name,
    String path,
    String current,
  ) {
    final action = {
      'module': '${path.split('\\').last}',
      'currentPathInterface': '${current}PathInterface',
      'currentNameFileInterface': '${current}NameFileInterface',
      'currentPath': '${current}Path',
      'currentNameFile': '${current}NameFile',
      'currentNameClassInterface': '${current}NameClassInterface',
      'currentNameClass': '${current}NameClass',
      'name': name,
      'path': path,
      'integration': ConfigsFile.getIntegration(),
      'repositoryPathInterface': ConfigsFile.getRepositoryPathInterface(),
      'repositoryNameFileInterface':
          ConfigsFile.getRepositoryNameFileInterface(),
      'repositoryPath': ConfigsFile.getRepositoryPath(),
      'repositoryNameFile': ConfigsFile.getRepositoryNameFile(),
      'repositoryNameClassInterface':
          ConfigsFile.getRepositoryNameClassInterface(),
      'repositoryNameClass': ConfigsFile.getRepositoryNameClass(),
      'datasourcePathInterface': ConfigsFile.getDatasourcePathInterface(),
      'datasourceNameFileInterface':
          ConfigsFile.getDatasourceNameFileInterface(),
      'datasourcePath': ConfigsFile.getDatasourcePath(),
      'datasourceNameFile': ConfigsFile.getDatasourceNameFile(),
      'datasourceNameClassInterface':
          ConfigsFile.getDatasourceNameClassInterface(),
      'datasourceNameClass': ConfigsFile.getDatasourceNameClass(),
      'usecasePathInterface': ConfigsFile.getUsecasePathInterface(),
      'usecaseNameFileInterface': ConfigsFile.getUsecaseNameFileInterface(),
      'usecasePath': ConfigsFile.getUsecasePath(),
      'usecaseNameFile': ConfigsFile.getUsecaseNameFile(),
      'usecaseNameClassInterface': ConfigsFile.getUsecaseNameClassInterface(),
      'usecaseNameClass': ConfigsFile.getUsecaseNameClass(),
      'pagePath': ConfigsFile.getPagePath(),
      'pageNameFile': ConfigsFile.getPageNameFile(),
      'pageNameClass': ConfigsFile.getPageNameClass(),
      'controllerPath': ConfigsFile.getControllerPath(),
      'controllerNameFile': ConfigsFile.getControllerNameFile(),
      'controllerNameClass': ConfigsFile.getControllerNameClass(),
    };

    return action[word];
  }
}
