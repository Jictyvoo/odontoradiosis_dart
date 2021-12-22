import 'package:odontoradiosis/core/util/supported.dart';
import 'package:odontoradiosis_core/odontoradiosis_core.dart';

class SidebarController {
  double _effectContrastSliderValue;
  double _effectBrightnessSliderValue;
  double _effectInvertSliderValue;
  double _effectGrayscaleSliderValue;
  String selectedCurve = '';

  SidebarController()
      : _effectBrightnessSliderValue = ImageEffects.defaultValues.brightness,
        _effectContrastSliderValue = ImageEffects.defaultValues.contrast,
        _effectInvertSliderValue = ImageEffects.defaultValues.invert,
        _effectGrayscaleSliderValue = ImageEffects.defaultValues.grayscale;

  /// Normalize name
  static String _normalizeTracingName(String toNormalize) {
    return toNormalize.replaceAll(' ', '-').toLowerCase();
  }

  void undone() {
    /*final effectsManager = this.canvasService.effectsManager;
    effectsManager.reset();
    _effectContrastSliderValue = effectsManager.contrast;
    _effectBrightnessSliderValue = effectsManager.brightness;
    _effectInvertSliderValue = effectsManager.invert;
    _effectGrayscaleSliderValue = effectsManager.grayscale;*/
  }

  /// Add Curve canvas event listener
  void curveSelect(String curveName) {
    /*final tracingController = this.canvasService.tracingController;
    final canvasOdontoradiosis = this.canvasService.cephalometricCanvas;
    this.infoKeeper.selectedOptions.curve = '';
    tracingController.drawAllCurves();
    if (curveName != SupportedCephalometric.clearSelection) {
      final currentCurve = _normalizeTracingName(curveName);
      if (curveName == SupportedCephalometric.allCurves) {
        this.infoKeeper.selectedOptions.curve = currentCurve;
        this.infoKeeper.selectedOptions.isAllCurves = true;
        canvasOdontoradiosis.canvasCursor = 'move';
        tracingController.drawEntireCurveBox(false);
      } else {
        if (tracingController.curveExists(currentCurve)) {
          canvasOdontoradiosis.canvasCursor = 'move';
          this.infoKeeper.selectedOptions.curve = currentCurve;
          this.infoKeeper.selectedOptions.isAllCurves = false;
          tracingController.drawCurveBox(currentCurve, true);
          tracingController.drawPointCircle(currentCurve);
        }
      }
    } else {
      canvasOdontoradiosis.canvasCursor = 'crosshair';
    }*/
  }

  void landmarkSelect(String landmarkName) {
    /*final tracingController = this.canvasService.tracingController;
    final canvasOdontoradiosis = this.canvasService.cephalometricCanvas;
    this.infoKeeper.selectedOptions.landmark = landmarkName;
    if (selectedCurve.isNotEmpty) {
      selectedCurve.writeValue('');
      this.infoKeeper.selectedOptions.curve = '';
      tracingController.drawAllCurves();
      canvasOdontoradiosis.canvasCursor = 'crosshair';
    }*/
  }

  /// Apply the effect to the canvas image only if the effect is enabled
  void applyEffects(String effect, double? value) {
    //final effectsManager = this.canvasService.effectsManager;
    switch (effect) {
      case "grayscale":
        //effectsManager.grayscale = value ?? 0;
        _effectGrayscaleSliderValue = value ?? 0;
        break;
      case "invert":
        //effectsManager.invert = value ?? 0;
        _effectInvertSliderValue = value ?? 0;
        break;
      case "brightness":
        //effectsManager.brightness = value ?? 0;
        _effectBrightnessSliderValue = value ?? 0;
        break;
      case "contrast":
        //effectsManager.contrast = value ?? 0;
        _effectContrastSliderValue = value ?? 0;
        break;
      default:
        //effectsManager.grayscale = value ?? 0;
        _effectGrayscaleSliderValue = value ?? 0;
        break;
    }
    //effectsManager.updateFilterValues();
  }

  List<String> get supportedCurves => SupportedCephalometric.supportedCurves;

  List<String> get supportedLandmarks => SupportedCephalometric.supportedPoints;

  double get contrastValue {
    return _effectContrastSliderValue;
  }

  double get brightnessValue {
    return _effectBrightnessSliderValue;
  }

  double get negativeValue {
    return _effectInvertSliderValue;
  }

  double get grayscaleValue {
    return _effectGrayscaleSliderValue;
  }
}
