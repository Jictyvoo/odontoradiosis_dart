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

  /// Default values for all supported effects
  static const IEffectValues defaultValues = IEffectValues(
    brightness: 100,
    contrast: 100,
    grayscale: 0,
    invert: 0,
  );

  /// Default Constructor that sets all effects values to it default
  ImageEffects()
      : brightness = defaultValues.brightness,
        contrast = defaultValues.contrast,
        grayscale = defaultValues.grayscale,
        invert = defaultValues.invert;

  /// Returns css style values
  Map<String, double> getValues() {
    return {
      "brightness": brightness,
      "contrast": contrast,
      "grayscale": grayscale,
      "invert": invert
    };
  }

  /// Reset all effects
  void reset() {
    brightness = defaultValues.brightness;
    contrast = defaultValues.contrast;
    grayscale = defaultValues.grayscale;
    invert = defaultValues.invert;
  }
}
