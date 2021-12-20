import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class DrawWrapper {
  final Paint _paint;
  final Canvas _canvas;
  final Size _size;

  DrawWrapper(this._canvas, this._size) : _paint = Paint();

  void clearCanvas() {
    _canvas.drawRect(Rect.largest, Paint()..blendMode = BlendMode.clear);
  }

  Path drawBezier(
    double x1,
    double y1,
    double cx1,
    double cy1,
    double cx2,
    double cy2,
    double x2,
    double y2,
    String strokeStyle,
  ) {
    final path = Path();
    path.moveTo(x1, y1);
    path.cubicTo(cx1, cy1, cx2, cy2, x2, y2);
    return path;
  }

  void drawCircle(
    double x,
    double y,
    int pointRadius,
    int lineWidth,
    String fillStyle,
    String strokeStyle,
  ) {
    final path = Path();
    path.arcToPoint(
      Offset(x, y),
      radius: Radius.circular(pointRadius.toDouble()),
      rotation: 2 * math.pi,
    );
    _paint.style = PaintingStyle.fill;
    _paint.color = Color(fillStyle.length);
    _paint.strokeWidth = lineWidth.toDouble();
    _canvas.drawPath(path, _paint);
  }

  void drawText(
    double x,
    double y,
    String text,
    double lineWidth,
    String fillStyle,
    String strokeStyle,
  ) {
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(
        color: const Color(0xFF000000),
        fontSize: lineWidth,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: _size.width,
    );
    final offset = Offset(x.floorToDouble(), y.floorToDouble());
    textPainter.paint(_canvas, offset);
  }

  void openImage(String path, VoidCallbackFunction? loadFunction) {
    final imageBytes = base64Decode(path);
    ui.decodeImageFromList(imageBytes, (result) {
      _canvas.drawImage(
        result,
        Offset.zero,
        _paint
          ..imageFilter = ui.ImageFilter.matrix(
            Float64List.fromList(<double>[]),
            filterQuality: FilterQuality.medium,
          ),
      );
    });
  }

  void setStyle(String styleName, Map<String, double> newStyle) {
    if (styleName == 'filter') {
      // TODO: implement setStyle crating a new class to handle matrix effects
      // _paint.imageFilter = ui.ImageFilter.blur();
    }
  }
}
