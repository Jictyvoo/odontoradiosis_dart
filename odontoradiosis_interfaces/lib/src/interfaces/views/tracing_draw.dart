import 'package:odontoradiosis_interfaces/src/models/types/curve_manipulation.dart';

import 'canvases/canvas_render_context.dart';

abstract class ITracingDraw {
  /// Clear the canvas.
  void clearCanvas();

  /// Draw a single curve on the canvas.
  /// @param curvePoints
  void drawCurve(IBezierPoints curvePoints);

  /// Draw all control points in a given curve
  /// @param {IBezierPoints} curvePoints
  void drawPointCircle(IBezierPoints curvePoints);

  /// @param {CanvasRenderingContext2D} context
  /// @param {array} boxDimensions
  void drawBoxVertex(CanvasRenderingContext2D context, List<double> boxDimensions);

  /// @param {string} currentCurve
  /// @param {array} boxDimensions
  void drawCurveBox(List<double> boxDimensions);
}
