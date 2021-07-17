abstract class IGenerateEntity {
  Future<bool> call({
    required String entityName,
    required String path,
    required String subPath,
  });
}
