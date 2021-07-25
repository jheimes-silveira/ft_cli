abstract class IGenerateUsecases {
  Future<bool> call({
    required String name,
    required String path,
    required String current,
  });

  String getNameFile(String name, String current);
  String getNameFileInterface(String name, String current);
  String getNameClass(String name, String current);
  String getNameClassInterface(String name, String current);
  String getPath();
  String getPathInterface();
}
