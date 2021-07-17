abstract class IGenerateRepositories {
  Future<bool> call({
    required String repositoryName,
    required String path,
    required String subPath,
    required String subPathInterface,
  });
}
