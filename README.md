# JS Arch CLI

## Code generator to facilitate development

Get Start:
```bash
dart pub global activate js_cli
```

or

```bash
dart pub global activate --source path ./RepositoryProject
```

### Overview

Para tornar mais fácil e intuitivo implementar a Arquitetura _Uncle Bob's Clean Architecture_. Esta CLI fornece a estrutura base, onde irá gerar dinamicamente as Classes conforme mostrado nos exemplos abaixo.


### Commands:

```bash
# Generate Feature
js_cli g layer complete /lib/src/features/home
```
<details>
<summary>Result</summary>

![](./screenshots/layer.png)
</details>

--- 

```bash
# Generate Entity
js_cli g entity /lib/src/features/home Home
```
<details>
<summary>Result</summary>

```dart
// home.entitiy.dart 
class HomeEntity {

  HomeEntity();

}
```
![](./screenshots/entity.png)
</details>

--- 

```bash
# Generate UseCase
js_cli g usecase /lib/src/features/home GetHomeCards
```
<details>
<summary>Result</summary>

```dart
//get_home_cards.usecase.dart
abstract class GetHomeCardsUsecase {
  Future<void> call();
}
```
```dart
//get_home_cards_imp.usecase.dart
import 'get_home_cards_usecase.dart';

class GetHomeCardsImpUsecase implements GetHomeCardsUsecase {
  @override
  Future<void> call() {
    // TODO: implement call
    throw UnimplementedError();
  }
  
}
  
```
![](./screenshots/usecase.png)
</details>

--- 

```bash
# Generate Repository
js_cli g repository /lib/src/features/home GetHomeCards
```
<details>
<summary>Result</summary>

```dart
// domain/repositories/get_home_cards.repository.dart
abstract class GetHomeCardsRepository {
  Future<void> call();
}
```
```dart
// data/repositories/get_home_cards_imp.repository.dart
import '../../domain/repositories/get_home_cards_repository.dart';

class GetHomeCardsImpRepository implements GetHomeCardsRepository {
  @override
  Future<void> call() {
    // TODO: implement call
    throw UnimplementedError();
  }
}
```
![](./screenshots/repository.png)
</details>

--- 

```bash
# Generate Dto
js_cli g dto /lib/src/features/home Home
```
<details>
<summary>Result</summary>

```dart
// home_dto.dart
import '../../domain/models/entities/home_entity.dart';

class HomeDto extends HomeEntity {

  HomeDto() : super();

}
```
![](./screenshots/dto.png)
</details>

--- 

```bash
# Generate Error
js_cli g error /lib/src/core/errors Generic  
```
<details>
<summary>Result</summary>

```dart
// generic.error.dart
class GenericError implements Exception {
  final String _message;
  final Exception innerException;

  GenericError(String message, this.innerException) : _message = message;

  String get message => _message;
}
```
![](./screenshots/error.png)
</details>

---

```bash

$ js_cli g layer complete ./teste/features/dashboard
################### Clean Arch CLI ###################
generating complete layer....
COMPLETE layer created

$ js_cli g entity ./teste/features/dashboard Viewer
################### Clean Arch CLI ###################
generating usecase Viewer....
Viewer created

$ js_cli g usecase ./teste/features/dashboard getViewer
################### Clean Arch CLI ###################
generating usecase getViewer....
getViewer created

$ js_cli g repository ./teste/features/dashboard getViewer
################### Clean Arch CLI ###################
generating repository getViewer....
getViewer created

$ js_cli g dto ./teste/features/dashboard Viewer
################### Clean Arch CLI ###################
generating dto Viewer....
ViewerDto created

```
---
### Palavras reservadas

Reserved words can be used in the templet files that are generated in .js_cli/templete the reserved words must be used inside mustaches `{{}}` example `{{name}}`, can also be used in reserved words an extension, example `{{name.pascalCase}}` whose extension will format the word as needed, you can check the lists below for all reserved words and extensions

Palavras reservadas podem ser usadas nos arquivos de modelo que são gerados em .js_cli/templete as palavras reservadas devem ser usadas dentro de _mustaches_ `{{}}` exemplo `{{nome}}`, também podem ser usadas em palavras reservadas uma extensão, exemplo `{{name.pascalCase}}` cuja extensão formatará a palavra conforme necessário, você pode verificar as listas abaixo para todas as palavras reservadas e extensões

* `Palavras reservadas podem ser editadas em meu_projeto\.js_cli\configs.json`

| Palavras reservadas               | `default`                                                                                                   |
|------------------------------|-----------------------------------------------------------------------------------------------------------|
| name                         | Entrada pelo terminal, este valor é o último parâmetro da expressão para gerar os modelos |
| path                         | Entrada pelo terminal, caminho onde o novo arquivo será gerado                                       |
| module                       | input input by the terminal, name of the module that will generate the new files                          |
| fileExtension                | `dart`                                                                                                      |
| repositoryPathInterface      | domain/repositories                                                                                       |
| repositoryNameFileInterface  | {{name.snakeCase}}_repository                                                                             |
| repositoryPath               | data/repositories                                                                                         |
| repositoryNameFile           | {{name.snakeCase}}_imp_repository                                                                         |
| repositoryNameClassInterface | {{name.pascalCase}}Repository                                                                             |
| repositoryNameClass          | {{name.pascalCase}}ImpRepository                                                                          |
| datasourcePathInterface      | data/datasources                                                                                          |
| datasourceNameFileInterface  | {{name.snakeCase}}_datasource                                                                             |
| datasourcePath               | external/datasources                                                                                      |
| datasourceNameFile           | {{name.snakeCase}}_imp_datasource                                                                         |
| datasourceNameClassInterface | {{name.pascalCase}}Datasource                                                                             |
| datasourceNameClass          | {{name.pascalCase}}ImpDatasource                                                                          |
| usecasePathInterface         | domain/usecases                                                                                           |
| usecaseNameFileInterface     | {{name.snakeCase}}_usecase                                                                                |
| usecasePath                  | domain/usecases                                                                                           |
| usecaseNameFile              | {{name.snakeCase}}_imp_usecase                                                                            |
| usecaseNameClassInterface    | {{name.pascalCase}}Usecase                                                                                |
| usecaseNameClass             | {{name.pascalCase}}ImpUsecase                                                                             |
| pagePath                     | presentation/ui/pages/{{name.snakeCase}}                                                                  |
| pageNameFile                 | {{name.snakeCase}}_page                                                                                   |
| pageNameClass                | {{name.pascalCase}}Page                                                                                   |
| controllerPath               | presentation/ui/pages/{{name.snakeCase}}                                                                  |
| controllerNameFile           | {{name.snakeCase}}_controller                                                                             |
| controllerNameClass          | {{name.pascalCase}}Controller                                                                             |

### Extensions

| extension    | Exemple    |
|--------------|------------|
| camelCase    | testeCase  |
| constantCase | TESTE_CASE |
| sentenceCase | Teste case |
| snakeCase    | teste_case |
| dotCase      | teste.case |
| paramCase    | teste-case |
| pathCase     | teste/case |
| pascalCase   | TesteCase  |
| headerCase   | Teste-Case |
| titleCase    | Teste Case |

### Triggers

##### Replace

in .js_cli/templete a {{term}}_replace_trigger.json file is generated where from your annotation it can apply a replace to any input expression, for example:

Em .js_cli/templete, um arquivo {{term}}_replace_trigger.json é gerado onde, a partir de sua anotação, ele pode aplicar uma substituição a qualquer expressão de entrada, por exemplo:
```json
[
    {
        "pathFile": "{{path}}\\{{module}}_module.dart",
        "from": "//imports",
        "to": "//imports\nimport '{{controllerPath}}/{{controllerNameFile}}.dart';"
    },
    {
        "pathFile": "{{path}}\\{{module}}_module.dart",
        "from": "//Dependence",
        "to": "//Dependence\nfinal {{controllerNameClass.camelCase}} = {{controllerNameClass.pascalCase}};"
    }
]
```
Onde irá executar um _replace_ no arquivo apontado, a partir da expressão

##### Criar novo arquivo

in .js_cli / templete, a file {{term}} _ new_file_trigger.json is generated where, from his annotation, he can create a new file with the pre-defined templete, for example:

Note, the ``generate`` variable must be ``true`` to generate the file.
em .js_cli/templete, um arquivo {{term}}_new_file_trigger.json é gerado onde, a partir de sua anotação, ele pode criar um novo arquivo com o modelo predefinido, por exemplo:

Observe que a variável ``generate`` deve ser ``true`` para gerar o arquivo.

```json
[
    {
        "pathFile": "{{path}}\\{{module}}_module",
        "pathTemplete": ".js_cli/template/layer/complete_new_file_exemple.template",
        "generate": true
    }
]
```

Templete

 ``.js_cli/template/layer/complete_new_file_exemple.template``

```file
class {{module.pascalCase}}Module extends Module {
  @override
  final List<Bind> binds = [
    //Usercases

    //Repositories

    //Datasources
      
    //Controllers
  ];

  @override
  final List<ModularRoute> routes = [
    //Pages
  ];
}

```
Onde irá gerar um novo arquivo partir do templete definido.