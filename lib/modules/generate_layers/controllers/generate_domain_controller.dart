import 'package:js_cli/core/interfaces/igenerate_page.dart';
import 'package:path/path.dart' as p;

import '../../../core/errors/file_exists_error.dart';
import '../../../core/interfaces/igenerate_datasources.dart';
import '../../../core/interfaces/igenerate_dto.dart';
import '../../../core/interfaces/igenerate_entity.dart';
import '../../../core/interfaces/igenerate_error.dart';
import '../../../core/interfaces/igenerate_repositories.dart';
import '../../../core/interfaces/igenerate_usecases.dart';
import '../../../core/utils/output_utils.dart' as output;

class GenerateDomainController {
  final IGenerateUsecases _generateUsecases;
  final IGenerateEntity _generateEntity;
  final IGenerateError _generateError;
  final IGenerateRepositories _generateRepositories;
  final IGenerateDto _generateDto;
  final IGenerateDatasources _generateDatasources;
  final IGeneratePages _generatePages;

  GenerateDomainController(
    this._generateUsecases,
    this._generateEntity,
    this._generateError,
    this._generateRepositories,
    this._generateDto,
    this._generateDatasources,
    this._generatePages,
  );

  Future<bool> generateUsecase(String usecaseName, String path) async {
    output.warn('generating usecase $usecaseName....');
    var pathNomalized = p.normalize('${p.current}/$path');

    try {
      var result = await _generateUsecases.call(
        name: usecaseName,
        path: pathNomalized,
      );

      if (result) {
        output.title('$usecaseName created');
        return true;
      }
      output.error('Directory not exists');
      return false;
    } on FileExistsError catch (e) {
      output.error(e.message);
      return false;
    }
  }

  Future<bool> generateEntity(String entityName, String path) async {
    output.warn('generating entity $entityName....');
    var pathNomalized = p.normalize('${p.current}/$path');
    try {
      var result = await _generateEntity.call(
        entityName: entityName,
        path: pathNomalized,
        subPath: 'domain/models/entities',
      );
      if (result) {
        output.title('$entityName created');
        return true;
      }
      output.error('Directory not exists');
      return false;
    } on FileExistsError catch (e) {
      output.error(e.message);
      return false;
    }
  }

  Future<bool> generateError(String errorName, String path) async {
    output.warn('generating error $errorName....');
    var pathNomalized = p.normalize('${p.current}/$path');
    try {
      var result = await _generateError.call(errorName, pathNomalized);
      if (result) {
        output.title('$errorName created');
        return true;
      }
      output.error('Directory not exists');
      return false;
    } on FileExistsError catch (e) {
      output.error(e.message);
      return false;
    }
  }

  Future<bool> generateRepository(String repositoryName, String path) async {
    output.warn('generating repository $repositoryName....');
    var pathNomalized = p.normalize('${p.current}/$path');
    try {
      var result = await _generateRepositories.call(
        name: repositoryName,
        path: pathNomalized,
      );
      if (result) {
        output.title('$repositoryName created');
        return true;
      }
      output.error('Directory not exists');
      return false;
    } on FileExistsError catch (e) {
      output.error(e.message);
      return false;
    }
  }

  Future<bool> generateDatasource(String datasourceName, String path) async {
    output.warn('generating repository $datasourceName....');
    var pathNomalized = p.normalize('${p.current}/$path');
    try {
      var result = await _generateDatasources.call(
        name: datasourceName,
        path: pathNomalized,
      );
      if (result) {
        output.title('$datasourceName created');
        return true;
      }
      output.error('Directory not exists');
      return false;
    } on FileExistsError catch (e) {
      output.error(e.message);
      return false;
    }
  }

  Future<bool> generatePage(String pageName, String path) async {
    output.warn('generating repository $pageName....');
    var pathNomalized = p.normalize('${p.current}/$path');
    try {
      var result = await _generatePages.call(
        name: pageName,
        path: pathNomalized,
      );
      if (result) {
        output.title('$pageName created');
        return true;
      }
      output.error('Directory not exists');
      return false;
    } on FileExistsError catch (e) {
      output.error(e.message);
      return false;
    }
  }

  Future<bool> generateDto(String dtoName, String path) async {
    output.warn('generating dto $dtoName....');
    var pathNomalized = p.normalize('${p.current}/$path');
    try {
      var result = await _generateDto.call(
        dtoName: dtoName,
        path: pathNomalized,
        subPath: 'domain/models/dtos',
      );
      if (result) {
        output.title('${dtoName}Dto created');
        return true;
      }
      output.error('Directory not exists');
      return false;
    } on FileExistsError catch (e) {
      output.error(e.message);
      return false;
    }
  }
}
