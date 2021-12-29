import 'package:odontoradiosis/core/util/supported.dart';
import 'package:odontoradiosis_core/odontoradiosis_core.dart';

class SidebarController {
  String _selectedCurve = '';
  final CephalometricCanvasService _canvasService;

  SidebarController(this._canvasService);

  /// Normalize name
  static String _normalizeTracingName(String toNormalize) {
    return toNormalize.replaceAll(' ', '-').toLowerCase();
  }

  void undone() {
    final effectsManager = _canvasService.effectsManager;
    effectsManager.reset();
    effectsManager.contrast = effectsManager.contrast;
    effectsManager.brightness = effectsManager.brightness;
    effectsManager.invert = effectsManager.invert;
    effectsManager.grayscale = effectsManager.grayscale;
  }

  /// Add Curve canvas event listener
  void curveSelect(String curveName) {
    _selectedCurve = curveName;
    final tracingController = _canvasService.tracingController;

    // Make it empty
    _canvasService.controller.selectCurve('');
    tracingController.drawAllCurves();
    if (curveName != SupportedCephalometric.clearSelection) {
      final currentCurve = _normalizeTracingName(curveName);
      if (curveName == SupportedCephalometric.allCurves) {
        _canvasService.controller.selectAllCurves(curveName);
      } else {
        if (tracingController.curveExists(currentCurve)) {
          _canvasService.controller.selectCurve(currentCurve);
        }
      }
    }
  }

  void landmarkSelect(String landmarkName) {
    final tracingController = _canvasService.tracingController;
    _canvasService.controller.landmark = landmarkName;
    if (_selectedCurve.isNotEmpty) {
      _selectedCurve = '';
      _canvasService.controller.selectCurve('');
      tracingController.drawAllCurves();
    }
  }

  /// Apply the effect to the canvas image only if the effect is enabled
  void applyEffects(String effect, double? value) {
    final effectsManager = _canvasService.effectsManager;
    switch (effect) {
      case "grayscale":
        //effectsManager.grayscale = value ?? 0;
        effectsManager.grayscale = value ?? 0;
        break;
      case "invert":
        //effectsManager.invert = value ?? 0;
        effectsManager.invert = value ?? 0;
        break;
      case "brightness":
        //effectsManager.brightness = value ?? 0;
        effectsManager.brightness = value ?? 0;
        break;
      case "contrast":
        //effectsManager.contrast = value ?? 0;
        effectsManager.contrast = value ?? 0;
        break;
      default:
        //effectsManager.grayscale = value ?? 0;
        effectsManager.grayscale = value ?? 0;
        break;
    }
    //effectsManager.updateFilterValues();
  }

  List<String> get supportedCurves => SupportedCephalometric.supportedCurves;

  List<String> get supportedLandmarks => SupportedCephalometric.supportedPoints;

  String? get selectedCurve =>
      _selectedCurve.isNotEmpty ? _selectedCurve : null;

  double get contrastValue {
    return _canvasService.effectsManager.contrast;
  }

  double get brightnessValue {
    return _canvasService.effectsManager.brightness;
  }

  double get negativeValue {
    return _canvasService.effectsManager.invert;
  }

  double get grayscaleValue {
    return _canvasService.effectsManager.grayscale;
  }
}
