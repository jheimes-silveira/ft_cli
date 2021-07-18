abstract class IGenerateDto {
  Future<bool> call({
    required String dtoName,
    required String path,
    required String subPath,
  });
}
