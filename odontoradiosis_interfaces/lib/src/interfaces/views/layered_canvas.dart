import 'canvas_draw.dart';

abstract class ILayeredCanvas {
  /// Add a canvas element in the manipulated canvas array
  void addCanvasElement(String canvasId, ICanvasDraw element);

  /// Change the cursor of the canvas stacks
  set canvasCursor(String newCursor);

  /// Sets the rendering layer order
  set layerOrder(Map<String, int> order);

  ICanvasDraw? getLayer(String id);
}
