import 'dart:math' as math;

import 'package:odontoradiosis_core/src/models/business/tracing_curve.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

abstract class AbstractBezierController implements AbsTracingManager {
  @override
  AnatomicalTracingCurve? getTracing(String curveName);

  /// Translate a curve
  void translateBezier(String curveName, double amountX, double amountY) {
    getTracing(curveName)?.updatePoints(
      (pointX, pointY) {
        return pointX - amountX;
      },
      (pointY, pointX) {
        return pointY - amountY;
      },
      false,
    );
  }

  /// Rotate a bezier curve
  void rotateBezier(String curveName, double angle) {
    getTracing(curveName)?.updatePoints(
      (pointX, pointY) {
        return pointX * math.cos(angle) - pointY * math.sin(angle);
      },
      (pointY, pointX) {
        return pointX * math.sin(angle) + pointY * math.cos(angle);
      },
    );
  }

  /// Rescale all bezier curves, based on scales given
  void rescaleBezier(String curveName, double scaleX, double scaleY) {
    getTracing(curveName)?.updatePoints(
      (pointX, pointY) {
        return pointX * scaleX;
      },
      (pointY, pointX) {
        return pointY * scaleY;
      },
    );
  }
}
