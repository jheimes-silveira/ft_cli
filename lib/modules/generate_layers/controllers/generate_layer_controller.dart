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
    required String current,
  }) async {
    output.warn('generating $layer layer....');
    var pathNomalized = p.normalize('${p.current}/$path');
    var result;
    switch (layerClass) {
      case ClassLayer.Domain:
        result = await _domain.call(pathNomalized, current);
        break;
      case ClassLayer.Data:
        result = await _data.call(pathNomalized, current);
        break;
      case ClassLayer.Presentation:
        result = await _presentation.call(pathNomalized, current);
        break;
      case ClassLayer.Complete:
        result = await _complete.call(pathNomalized, current);
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
    required String current,
  }) async {
    switch (layerCommand) {
      case 'domain':
        await _generateLayer(
          layer: layerCommand,
          path: path,
          layerClass: ClassLayer.Domain,
          current: current,
        );
        break;
      case 'data':
        await _generateLayer(
          layer: layerCommand,
          path: path,
          layerClass: ClassLayer.Data,
          current: current,
        );
        break;
      case 'presentation':
        await _generateLayer(
          layer: layerCommand,
          path: path,
          layerClass: ClassLayer.Presentation,
          current: current,
        );
        break;
      case 'complete':
        await _generateLayer(
          layer: layerCommand,
          path: path,
          layerClass: ClassLayer.Complete,
          current: current,
        );
        break;
      default:
        output.error('This Layer not exists');
    }
  }
}
