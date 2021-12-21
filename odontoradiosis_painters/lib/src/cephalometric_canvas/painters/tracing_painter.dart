import 'package:flutter/material.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class AnatomicalTracingPainter extends CustomPainter {
  final TracingDrawInfo _drawInfo;

  AnatomicalTracingPainter(this._drawInfo);

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
      ..style = PaintingStyle.stroke
      ..strokeWidth = _drawInfo.strokeWidth ?? 4;

    final curveColor = _drawInfo.curveColor;
    if (curveColor != null) {
      paint.color = Color(curveColor.primary);
    }

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

  /// Draw all control points in a given curve
  void drawPointCircle(Canvas canvas, IBezierPoints curvePoints) {
    final radius = _drawInfo.curvePointRadius ?? 4;
    final paint = Paint()
      ..strokeWidth = _drawInfo.strokeWidth ?? 2
      ..style = PaintingStyle.fill
      ..color = Color(_drawInfo.curveColor?.secondary ?? 0xFF313399);
    for (var index = 0; index < curvePoints.length; index++) {
      final element = curvePoints[index];
      for (var subIndex = 1; subIndex < element.length; subIndex += 2) {
        final center = Offset(element[subIndex - 1], element[subIndex]);
        canvas.drawCircle(center, radius, paint);
      }
    }
  }

  void drawBoxVertex(Canvas canvas, BoxDimensions boxDimensions) {
    final radius = _drawInfo.boxVertexRadius ?? 3;
    final paint = Paint()
      ..strokeWidth = _drawInfo.strokeWidth ?? 2
      ..style = PaintingStyle.fill
      ..color = Color(_drawInfo.boxColor?.secondary ?? 0xFF313399);
    for (final element in [
      [boxDimensions.x, boxDimensions.y],
      [boxDimensions.x, boxDimensions.y + boxDimensions.heigth],
      [boxDimensions.x + boxDimensions.width, boxDimensions.y],
      [
        boxDimensions.x + boxDimensions.width,
        boxDimensions.y + boxDimensions.heigth,
      ],
    ]) {
      final center = Offset(element[0], element[1]);
      canvas.drawCircle(center, radius, paint);
    }
  }

  void drawCurveBox(Canvas canvas, BoxDimensions boxDimensions) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _drawInfo.strokeWidth ?? 3
      ..color = Color(_drawInfo.boxColor?.primary ?? 0xFFDC5E2C);
    final rect = Rect.fromLTWH(
      boxDimensions.x,
      boxDimensions.y,
      boxDimensions.width,
      boxDimensions.heigth,
    );
    canvas.drawRect(rect, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final tracing in _drawInfo.curvesList) {
      drawCurve(canvas, tracing);
    }

    if (_drawInfo.boxDimensions != null) {
      drawCurveBox(canvas, _drawInfo.boxDimensions!);
      drawBoxVertex(canvas, _drawInfo.boxDimensions!);
    }

    if (_drawInfo.curvePoints != null) {
      drawPointCircle(canvas, _drawInfo.curvePoints!);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
