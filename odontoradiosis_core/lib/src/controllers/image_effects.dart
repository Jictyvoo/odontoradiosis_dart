import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class ImageEffects implements IEffectValues {
  double brightness;
  double contrast;
  double grayscale;
  double invert;
  ICanvasDraw canvasManager;

  static const IEffectValues defaultValues = IEffectValues(
    brightness: 100,
    contrast: 100,
    grayscale: 0,
    invert: 0,
  );

  ImageEffects(ICanvasDraw canvas)
      : brightness = defaultValues.brightness,
        contrast = defaultValues.contrast,
        grayscale = defaultValues.grayscale,
        invert = defaultValues.invert,
        canvasManager = canvas;

  /// Returns css style values
  String getValues() {
    final filterStyle =
        "brightness($brightness%) contrast($contrast%) grayscale($grayscale%) invert($invert%)";
    return filterStyle;
  }

  /// Event function that apply read and apply effects on image
  void updateFilterValues() {
    final filterValue = getValues();
    canvasManager.setStyle(
        ICanvasLayers.BACKGROUND.value, 'filter', filterValue);
  }

  /// Reset all effects
  void reset() {
    brightness = 100;
    contrast = 100;
    grayscale = 0;
    invert = 0;
    updateFilterValues();
  }
}
