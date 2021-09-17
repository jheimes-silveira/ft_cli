import 'microfrontend.dart';

class MicroApp extends Microfrontend {
  static const String keyComponent = 'componentMicroApp';
  static const String keyPrefix = 'prefixMicroApp';

  @override
  String get component {
    return persistValue(
      keyComponent,
      'micro_app',
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
