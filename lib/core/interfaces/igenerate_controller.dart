abstract class IGenerateController {
  Future<bool> call({
    required String name,
    required String path,
  });

  String getNameFile(String name);
  String getNameClass(String name);
  String getPath();
}
