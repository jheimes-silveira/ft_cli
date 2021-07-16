abstract class IGenerateRepositories {
  Future<bool> call(String repositoryName, String path, String pathInterface);
}
