import 'microfrontend.dart';

class MicroCommons extends Microfrontend {
  static const String keyComponent = 'componentMicroCommons';
  static const String keyPrefix = 'prefixMicroCommons';

  @override
  String get component {
    return persistValue(
      keyComponent,
      'micro_commons',
    );
  }

  @override
  String get prefix {
    return persistValue(
      keyPrefix,
      'flut',
    );
  }
}
