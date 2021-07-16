abstract class IGenerateDatasources {
  Future<bool> call(
    String datasourceName,
    String pathInterface,
    String path,
  );
}
