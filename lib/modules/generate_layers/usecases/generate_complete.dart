import 'dart:io';

import '../../../core/interfaces/igenerate_layers.dart';

class GenerateComplete implements IGenerateLayers {
  final IGenerateLayers _gnDomain;
  final IGenerateLayers _gnData;
  final IGenerateLayers _gnPresentation;
  final IGenerateLayers _gnExternal;

  GenerateComplete(
    this._gnDomain,
    this._gnData,
    this._gnPresentation,
    this._gnExternal,
  );

  @override
  Future<bool> call(String path) async {
    var isValidDirectory = await Directory(path).exists();
    if (!isValidDirectory) await Directory(path).create(recursive: true);

    await _gnDomain(path);
    await _gnData(path);
    await _gnPresentation(path);
    await _gnExternal(path);
    return true;
  }
}
