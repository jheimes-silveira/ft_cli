abstract class IGenerateDatasources {
  Future<bool> call({
    required String datasourceName,
    required String path,
    required String subPath,
    required String subPathInterface,
  });
}
