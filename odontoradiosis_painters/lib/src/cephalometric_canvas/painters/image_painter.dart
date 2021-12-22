import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class ImagePainter extends CustomPainter {
  final ImageDrawInfo _drawInfo;
  final ui.Image _image;

  ImagePainter(this._drawInfo, this._image);

  void drawImage(Canvas canvas) {
    canvas.drawImage(
      _image,
      Offset.zero,
      Paint(),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawImage(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
