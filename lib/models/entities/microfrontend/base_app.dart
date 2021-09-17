import 'microfrontend.dart';

class BaseApp extends Microfrontend {
  static const String keyComponent = 'componentBaseApp';
  static const String keyPrefix = 'prefixBaseApp';

  @override
  String get component {
    return persistValue(
      keyComponent,
      'base_app',
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
