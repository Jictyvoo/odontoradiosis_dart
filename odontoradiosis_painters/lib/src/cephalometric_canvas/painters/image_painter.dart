import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class ImagePainter extends CustomPainter {
  final ImageDrawInfo _drawInfo;
  final ui.Image _image;

  ImagePainter(this._drawInfo, this._image);

  void drawImage(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      _drawInfo.offset?.x ?? 0,
      _drawInfo.offset?.y ?? 0,
      size.width * (_drawInfo.scales?.x ?? 1),
      size.height,
    );
    paintImage(
      canvas: canvas,
      rect: rect,
      image: _image,
      fit: BoxFit.fitWidth,
      repeat: ImageRepeat.noRepeat,
      scale: 1.0,
      alignment: Alignment.topLeft,
      flipHorizontally: false,
      filterQuality: FilterQuality.high,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawImage(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
