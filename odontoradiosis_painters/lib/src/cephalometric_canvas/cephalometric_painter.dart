import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

import 'painters/image_painter.dart';
import 'painters/landmark_painter.dart';
import 'painters/tracing_painter.dart';

class CephalometricPainter extends CustomPainter {
  final TracingDrawInfo anatomicalTracing;
  final LandmarkDrawInfo landmarkDrawInfo;
  final ImageDrawInfo imageDrawInfo;
  final ui.Image? _image;

  CephalometricPainter(
    this.anatomicalTracing,
    this.landmarkDrawInfo,
    this.imageDrawInfo,
    this._image,
  );

  @override
  void paint(Canvas canvas, Size size) {
    if (_image != null) {
      final imagePainter = ImagePainter(imageDrawInfo, _image!);
      imagePainter.paint(canvas, size);
    }
    final tracingPainter = AnatomicalTracingPainter(anatomicalTracing);
    tracingPainter.paint(canvas, size);

    final landmarkPainter = LandmarkPainter(landmarkDrawInfo);
    landmarkPainter.paint(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
