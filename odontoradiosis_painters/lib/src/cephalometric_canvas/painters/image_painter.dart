import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class ImagePainter extends CustomPainter {
  final ImageDrawInfo _drawInfo;
  ui.Image? _image;

  ImagePainter(this._drawInfo) : _image = null;

  void openImage(VoidCallbackFunction? loadFunction) {
    ui.decodeImageFromList(_drawInfo.imageData, (result) {
      _image = result;
      if (loadFunction != null) {
        loadFunction();
      }
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (_image != null) {
      canvas.drawImage(
        _image!,
        Offset.zero,
        Paint()
          ..imageFilter = ui.ImageFilter.matrix(
            Float64List.fromList(<double>[]),
            filterQuality: FilterQuality.medium,
          ),
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
