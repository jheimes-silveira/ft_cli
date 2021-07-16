abstract class IGenerateDto {
  Future<bool> call(String dtoName, String path);
}
