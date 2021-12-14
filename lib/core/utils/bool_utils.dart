
class BoolUtils {
  static bool parse(dynamic value) {
    if (value is bool) return value;

    if (value is String) {
      if (value == '1') return true;
      if (value == 'true') return true;
    }
  
    if (value is int || value is double) {
      if (value > 0) return true;
    }

    return false;
  }
}
