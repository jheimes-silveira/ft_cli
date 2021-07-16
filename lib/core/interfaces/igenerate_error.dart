abstract class IGenerateError {
  Future<bool> call(String errorName, String path);
}
