import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class ImageEffects implements IEffectValues {
  @override
  double brightness;

  @override
  double contrast;

  @override
  double grayscale;

  @override
  double invert;

  final ICanvasDraw? _canvasLayer;

  static const IEffectValues defaultValues = IEffectValues(
    brightness: 100,
    contrast: 100,
    grayscale: 0,
    invert: 0,
  );

  ImageEffects([ICanvasDraw? canvas])
      : brightness = defaultValues.brightness,
        contrast = defaultValues.contrast,
        grayscale = defaultValues.grayscale,
        invert = defaultValues.invert,
        _canvasLayer = canvas;

  /// Returns css style values
  Map<String, double> getValues() {
    return {
      "brightness": brightness,
      "contrast": contrast,
      "grayscale": grayscale,
      "invert": invert
    };
  }

  /// Event function that apply read and apply effects on image
  void updateFilterValues() {
    final filterValue = getValues();
    _canvasLayer?.setStyle('filter', filterValue);
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
