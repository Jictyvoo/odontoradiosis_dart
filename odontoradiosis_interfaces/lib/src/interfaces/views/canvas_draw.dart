import '../../models/types/callbacks.dart';

@Deprecated(
  'This view will not be used anymore, now has to implement self internal views'
  ' that know how exactly will draw it',
)
abstract class ICanvasDraw {
  /// Apply a style to the canvas using UsefulMethods
  void setStyle(String styleName, Map<String, double> newStyle);

  /// Clear canvas that have the id passed
  void clearCanvas();

  /// Draw a circle in selected curve with selected colors
  void drawCircle(
    double x,
    double y,
    int pointRadius,
    int lineWidth,
    String fillStyle,
    String strokeStyle,
  );

  /// Draw a circle in selected curve with selected colors
  void drawText(
    double x,
    double y,
    String text,
    double lineWidth,
    String fillStyle,
    String strokeStyle,
  );

  /// Opens a given image and reset canvas size
  void openImage(String path, VoidCallbackFunction? loadFunction);
}
