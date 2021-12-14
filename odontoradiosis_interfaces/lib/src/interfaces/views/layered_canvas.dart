import 'canvas_draw.dart';
import 'canvases/canvas_render_context.dart';
import 'canvases/custom_canvas_element.dart';

abstract class ILayeredCanvas {
  /// Add a canvas element in the manipulated canvas array
  void addCanvasElement(String canvasId, HTMLCanvasElement element);

  /// Change the cursor of the canvas stacks
  set canvasCursor(String newCursor);

  /// Sets the rendering layer order
  set layerOrder(Map<String, int> order);

  ICanvasDraw? getLayer(String id);

  /// Returns a canvas based on it id
  HTMLCanvasElement getCanvas(String id);

  /// Returns a canvas context based on it id
  CanvasRenderingContext2D getContext(String id);
}
