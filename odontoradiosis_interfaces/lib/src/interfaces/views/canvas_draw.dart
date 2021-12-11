import '../../models/types/callbacks.dart';
import '../controllers/scales_controller.dart';
import 'canvases/canvas_render_context.dart';
import 'canvases/custom_canvas_element.dart';

abstract class ICanvasDraw {
  /// Add a canvas element in the manipulated canvas array
  /// @param canvasId
  /// @param element
  void addCanvasElement(String canvasId, HTMLCanvasElement element);

  /// Change the cursor of the canvas stacks
  set canvasCursor(String newCursor);

  /// Returns a canvas based on it id
  /// @param {string} id
  /// @returns {HTMLCanvasElement}
  HTMLCanvasElement getCanvas(String id);

  /// Returns a canvas context based on it id
  /// @param {string} id
  /// @returns {CanvasRenderingContext2D}
  CanvasRenderingContext2D getContext(String id);

  /// Returns the scale manager object
  IScalesController get scales;

  /// Apply a style to the canvas using UsefulMethods
  /// @param {string} id
  /// @param {string} styleName
  /// @param {string} newStyle
  void setStyle(String id, String styleName, String newStyle);

  /// Clear canvas that have the id passed
  /// @param {string} canvasId
  void clearCanvas(String canvasId);

  /// Draw a circle in selected context with selected colors
  /// @param {CanvasRenderingContext2D} context
  /// @param {number} x
  /// @param {number} y
  /// @param {number} pointRadius
  /// @param {number} lineWidth
  /// @param {string} fillStyle
  /// @param {string} strokeStyle
  void drawCircle(
    CanvasRenderingContext2D context,
    double x,
    double y,
    int? pointRadius,
    int? lineWidth,
    String? fillStyle,
    String? strokeStyle,
  );

  /// Draw a circle in selected curve with selected colors
  /// @param {string} layerId
  /// @param {number} x
  /// @param {number} y
  /// @param {number} pointRadius
  /// @param {number} lineWidth
  /// @param {string} fillStyle
  /// @param {string} strokeStyle
  void drawCircleCtx(
    String layerId,
    double x,
    double y,
    int pointRadius,
    int lineWidth,
    String fillStyle,
    String strokeStyle,
  );

  /// Draw a circle in selected curve with selected colors
  /// @param {string} layerId
  /// @param {number} x
  /// @param {number} y
  /// @param {number} pointRadius
  /// @param {number} lineWidth
  /// @param {string} fillStyle
  /// @param {string} strokeStyle
  void drawText(
    String layerId,
    double x,
    double y,
    String text,
    double lineWidth,
    String fillStyle,
    String strokeStyle,
  );

  /// @param {CanvasRenderingContext2D} context
  /// @param {number} x1
  /// @param {number} y1
  /// @param {number} cx1
  /// @param {number} cy1
  /// @param {number} cx2
  /// @param {number} cy2
  /// @param {number} x2
  /// @param {number} y2
  /// @param {string} strokeStyle
  void drawBezier(
    CanvasRenderingContext2D context,
    double x1,
    double y1,
    double cx1,
    double cy1,
    double cx2,
    double cy2,
    double x2,
    double y2,
    String strokeStyle,
  );

  /// Opens a given image and reset canvas size
  /// @param {string} path
  /// @param {VoidFunction} loadFunction
  void openImage(String path, VoidCallbackFunction? loadFunction);
}
