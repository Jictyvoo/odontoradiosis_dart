import 'dart:typed_data';

import '../bidimensional_point.dart';
import '../effects_values.dart';

class ImageDrawInfo {
  final Uint8List imageData;
  final IEffectValues? effects;
  final IPointBidimensional? scales;
  final IPointBidimensional? offset;

  const ImageDrawInfo(this.imageData, {this.effects, this.scales, this.offset});
}
