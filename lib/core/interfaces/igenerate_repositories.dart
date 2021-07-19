abstract class IGenerateRepositories {
  Future<bool> call({
    required String name,
    required String path,
  });

  String getNameFile(String name);
  String getNameFileInterface(String name);
  String getNameClass(String name);
  String getNameClassInterface(String name);
  String getPath();
  String getPathInterface();
}
