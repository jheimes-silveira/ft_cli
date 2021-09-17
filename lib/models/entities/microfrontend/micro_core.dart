import 'microfrontend.dart';

class MicroCore extends Microfrontend {
  static const String keyComponent = 'componentMicroCore';
  static const String keyPrefix = 'prefixMicroCore';

  @override
  String get component {
    return persistValue(
      keyComponent,
      'micro_core',
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
