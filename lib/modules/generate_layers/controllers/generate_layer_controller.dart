import 'package:get_it/get_it.dart';
import 'package:path/path.dart' as p;

import '../../../core/interfaces/igenerate_layers.dart';
import '../../../core/utils/output_utils.dart' as output;

enum ClassLayer { Domain, Data, Presentation, Complete }

class GenerateLayerController {
  final getIt = GetIt.instance;
  final IGenerateLayers _domain;
  final IGenerateLayers _data;
  final IGenerateLayers _presentation;
  final IGenerateLayers _complete;

  GenerateLayerController(
    this._domain,
    this._data,
    this._presentation,
    this._complete,
  );

  Future<void> _generateLayer({
    required String layer,
    required String path,
    required ClassLayer layerClass,
  }) async {
    output.warn('generating $layer layer....');
    var pathNomalized = p.normalize('${p.current}/$path');
    var result;
    switch (layerClass) {
      case ClassLayer.Domain:
        result = await _domain.call(pathNomalized);
        break;
      case ClassLayer.Data:
        result = await _data.call(pathNomalized);
        break;
      case ClassLayer.Presentation:
        result = await _presentation.call(pathNomalized);
        break;
      case ClassLayer.Complete:
        result = await _complete.call(pathNomalized);
        break;
      default:
    }
    if (result) {
      output.title('${layer.toUpperCase()} layer created');
      return;
    }
    output.error('Directory not exists');
  }

  Future<void> generateLayerFolders({
    required String layerCommand,
    required String path,
  }) async {
    switch (layerCommand) {
      case 'domain':
        await _generateLayer(
          layer: layerCommand,
          path: path,
          layerClass: ClassLayer.Domain,
        );
        break;
      case 'data':
        await _generateLayer(
          layer: layerCommand,
          path: path,
          layerClass: ClassLayer.Data,
        );
        break;
      case 'presentation':
        await _generateLayer(
          layer: layerCommand,
          path: path,
          layerClass: ClassLayer.Presentation,
        );
        break;
      case 'complete':
        await _generateLayer(
          layer: layerCommand,
          path: path,
          layerClass: ClassLayer.Complete,
        );
        break;
      default:
        output.error('This Layer not exists');
    }
  }
}
