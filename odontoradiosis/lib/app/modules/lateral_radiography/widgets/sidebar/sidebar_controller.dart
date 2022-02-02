import 'package:odontoradiosis/core/util/supported.dart';
import 'package:odontoradiosis_core/odontoradiosis_core.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class SidebarController {
  final LateralCephalometricService _canvasService;

  SidebarController(this._canvasService);

  void undone() {
    final effectsManager = _canvasService.effectsManager;
    effectsManager.reset();
    effectsManager.contrast = effectsManager.contrast;
    effectsManager.brightness = effectsManager.brightness;
    effectsManager.invert = effectsManager.invert;
    effectsManager.grayscale = effectsManager.grayscale;
  }

  /// Add Curve canvas event listener
  void curveSelect(TracingCurveDefinition curveDefinition) {
    final tracingController = _canvasService.tracingController;

    // Make it empty
    _canvasService.controller.selectCurve = '';
    tracingController.drawAllCurves();
    final curveName = curveDefinition.curveName;
    if (curveName != SupportedCephalometric.clearSelection) {
      if (curveName == SupportedCephalometric.allCurves) {
        _canvasService.controller.selectAllCurves(curveName);
      } else {
        if (tracingController.curveExists(curveName)) {
          _canvasService.controller.selectCurve = curveName;
        }
      }
    }
  }

  void landmarkSelect(LandmarkDefinition landmarkDefinition) {
    final tracingController = _canvasService.tracingController;
    _canvasService.controller.landmark = landmarkDefinition.toString();
    if (_canvasService.controller.selectCurve.isNotEmpty) {
      _canvasService.controller.selectCurve = '';
      tracingController.drawAllCurves();
    }
  }

  /// Apply the effect to the canvas image only if the effect is enabled
  void applyEffects(String effect, double? value) {
    final effectsManager = _canvasService.effectsManager;
    switch (effect) {
      case "grayscale":
        effectsManager.grayscale = value ?? 0;
        break;
      case "invert":
        effectsManager.invert = value ?? 0;
        break;
      case "brightness":
        effectsManager.brightness = value ?? 0;
        break;
      case "contrast":
        effectsManager.contrast = value ?? 0;
        break;
      default:
        effectsManager.grayscale = value ?? 0;
        break;
    }
    //effectsManager.updateFilterValues();
  }

  List<TracingCurveDefinition> get supportedCurves =>
      SupportedCephalometric.supportedCurves;

  List<LandmarkDefinition> get supportedLandmarks =>
      SupportedCephalometric.supportedPoints;

  // TODO: Remove direct string from controller save
  TracingCurveDefinition? get selectedCurve {
    final curveValue = _canvasService.controller.selectCurve;
    for (final definition in supportedCurves) {
      if (curveValue == definition.curveName) {
        return definition;
      }
    }
    return null;
  }

  LandmarkDefinition? get selectedLandmark {
    final landmarkValue = _canvasService.controller.landmark;
    for (final definition in supportedLandmarks) {
      if (landmarkValue == definition.toString()) {
        return definition;
      }
    }
    return null;
  }

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
