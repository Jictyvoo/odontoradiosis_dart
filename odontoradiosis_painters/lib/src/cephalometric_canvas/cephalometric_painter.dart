import 'package:flutter/material.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

import 'painters/landmark_painter.dart';
import 'painters/tracing_painter.dart';

class CephalometricPainter extends CustomPainter {
  final TracingDrawInfo anatomicalTracing;
  final LandmarkDrawInfo landmarkDrawInfo;

  CephalometricPainter(this.anatomicalTracing, this.landmarkDrawInfo);

  @override
  void paint(Canvas canvas, Size size) {
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
