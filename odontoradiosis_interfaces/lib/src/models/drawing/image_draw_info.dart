import 'dart:typed_data';

import '../effects_values.dart';

class ImageDrawInfo {
  final Uint8List imageData;
  final IEffectValues effects;

  ImageDrawInfo(this.imageData, this.effects);
}
