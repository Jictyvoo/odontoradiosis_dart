import 'package:flutter/material.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class LandmarkPainter extends CustomPainter {
  final LandmarkDrawInfo _drawInfo;

  LandmarkPainter(this._drawInfo);

  void drawText(Canvas canvas, Size size, SpecificLandmarkInfo info) {
    final textSpan = TextSpan(
      text: info.name,
      style: TextStyle(
        color: const Color(0xFF000000),
        fontSize: _drawInfo.fontSize,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final offset = Offset(
      info.textPosition.x.floorToDouble(),
      info.textPosition.y.floorToDouble(),
    );
    textPainter.paint(canvas, offset);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = _drawInfo.pointRadius ?? 4;
    final paint = Paint()
      ..strokeWidth = _drawInfo.strokeWidth ?? 2
      ..style = PaintingStyle.fill
      ..color = Color(_drawInfo.color?.primary ?? 0xFF962626);
    for (final landmarkInfo in _drawInfo.landmarks) {
      // Draw the point
      final center = Offset(landmarkInfo.point.x, landmarkInfo.point.y);
      canvas.drawCircle(center, radius, paint);

      // Draw the text
      drawText(canvas, size, landmarkInfo);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
