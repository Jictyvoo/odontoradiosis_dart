import 'package:flutter/material.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class CephalometricPainter extends CustomPainter {
  final ITracingCurves anatomicalTracing;

  CephalometricPainter(this.anatomicalTracing);

  Path _drawBezier(
    double x1,
    double y1,
    double cx1,
    double cy1,
    double cx2,
    double cy2,
    double x2,
    double y2,
  ) {
    final path = Path();
    path.moveTo(x1, y1);
    path.cubicTo(cx1, cy1, cx2, cy2, x2, y2);
    return path;
  }

  void drawCurve(Canvas canvas, IBezierPoints curvePoints) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final path = Path();
    for (var position = 0; position < curvePoints.length; position += 1) {
      final points = curvePoints[position];
      if (position == 0) {
        final subPath = _drawBezier(
          points[0],
          points[1],
          points[2],
          points[3],
          points[4],
          points[5],
          points[6],
          points[7],
        );
        path.addPath(subPath, Offset.zero);
      } else {
        final temporary = curvePoints[position - 1];
        final subPath = _drawBezier(
          temporary[temporary.length - 2],
          temporary[temporary.length - 1],
          points[0],
          points[1],
          points[2],
          points[3],
          points[4],
          points[5],
        );
        path.addPath(subPath, Offset.zero);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final tracing in anatomicalTracing.values) {
      drawCurve(canvas, tracing);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
