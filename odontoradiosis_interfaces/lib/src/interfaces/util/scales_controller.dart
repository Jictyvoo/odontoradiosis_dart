import 'package:odontoradiosis_interfaces/src/interfaces/views/canvases/canvas_render_context.dart';
import 'package:odontoradiosis_interfaces/src/interfaces/views/canvases/custom_canvas_element.dart';
import 'package:odontoradiosis_interfaces/src/interfaces/views/canvases/custom_client_rect.dart';
import 'package:odontoradiosis_interfaces/src/models/bidimensional_point.dart';

abstract class IScalesController {
  int get pointRadius;

  IPointBidimensional get textRelativePosition;

  /// Calculate the scale to make canvas dynamic and returns it
  double dynamicCanvasScale({
    double valueToResize = 1,
    bool isX = false,
    required CanvasRenderingContext2D context,
    required ClientRect clientRect,
  });

  /// Calculates all scales variables
  void calculateScales(HTMLCanvasElement canvas);

  /// Returns an object containing the relative mouse position in Canvas
  IPointBidimensional getMousePos(
    HTMLCanvasElement canvas,
    IPointBidimensional point,
  );
}
