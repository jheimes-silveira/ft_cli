import '../../core/interfaces/igenerate_datasources.dart';
import '../../core/interfaces/igenerate_dto.dart';
import '../../core/interfaces/igenerate_error.dart';
import '../../core/interfaces/igenerate_repositories.dart';
import '../../modules/generate_layers/usecases/core/generate_error.dart';
import '../../modules/generate_layers/usecases/data/generate_repositories.dart';
import 'package:get_it/get_it.dart';

import '../../core/interfaces/igenerate_entity.dart';
import '../../core/interfaces/igenerate_usecases.dart';
import 'controllers/generate_domain_controller.dart';
import 'controllers/generate_layer_controller.dart';
import 'usecases/data/generate_data.dart';
import 'usecases/data/generate_datasources.dart';
import 'usecases/data/generate_dto.dart';
import 'usecases/data/generate_external.dart';
import 'usecases/domain/generate_domain.dart';
import 'usecases/domain/generate_entity.dart';
import 'usecases/domain/generate_usecases.dart';
import 'usecases/generate_complete.dart';
import 'usecases/presentation/generate_presentation.dart';

class GenerateModule {
  final getIt = GetIt.instance;

  void _setup() {
    getIt.registerLazySingleton<IGenerateEntity>(() => GenerateEntity());
    getIt.registerLazySingleton<IGenerateUsecases>(() => GenerateUsecases());
    getIt.registerLazySingleton<IGenerateDto>(() => GenerateDto());
    getIt.registerLazySingleton<IGenerateDatasources>(
      () => GenerateDatasources(),
    );
    getIt.registerLazySingleton<IGenerateRepositories>(
      () => GenerateRepositories(),
    );

    getIt.registerLazySingleton<IGenerateError>(() => GenerateError());

    getIt.registerLazySingleton<GenerateDomain>(() => GenerateDomain());
    getIt.registerLazySingleton<GenerateData>(() => GenerateData());
    getIt.registerLazySingleton<GenerateExternal>(() => GenerateExternal());
    getIt.registerLazySingleton<GeneratePresentation>(
      () => GeneratePresentation(),
    );

    getIt.registerLazySingleton<GenerateComplete>(
      () => GenerateComplete(
        getIt.get<GenerateDomain>(),
        getIt.get<GenerateData>(),
        getIt.get<GeneratePresentation>(),
        getIt.get<GenerateExternal>(),
      ),
    );

    getIt.registerLazySingleton<GenerateLayerController>(
      () => GenerateLayerController(
        getIt.get<GenerateDomain>(),
        getIt.get<GenerateData>(),
        getIt.get<GeneratePresentation>(),
        getIt.get<GenerateComplete>(),
      ),
    );
    getIt.registerLazySingleton<GenerateDomainController>(
      () => GenerateDomainController(
        getIt.get<IGenerateUsecases>(),
        getIt.get<IGenerateEntity>(),
        getIt.get<IGenerateError>(),
        getIt.get<IGenerateRepositories>(),
        getIt.get<IGenerateDto>(),
        getIt.get<IGenerateDatasources>(),
      ),
    );
  }

  GenerateModule() {
    _setup();
  }
}
