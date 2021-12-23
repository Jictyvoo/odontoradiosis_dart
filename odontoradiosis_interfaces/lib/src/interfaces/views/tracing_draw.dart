import 'package:odontoradiosis_interfaces/src/models/types/curve_manipulation.dart';

@Deprecated(
  'This view will not be used anymore, now has to implement self internal views'
  ' that know how exactly will draw it',
)
abstract class ITracingDraw {
  /// Clear the canvas.
  void clearCanvas();

  /// Draw a single curve on the canvas.
  void drawCurve(IBezierPoints curvePoints);

  /// Draw all control points in a given curve
  void drawPointCircle(IBezierPoints curvePoints);

  void drawBoxVertex(List<double> boxDimensions);

  void drawCurveBox(List<double> boxDimensions);
}
