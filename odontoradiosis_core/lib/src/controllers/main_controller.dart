import 'package:odontoradiosis_core/src/models/odontoradiosis_keeper.dart';
import 'package:odontoradiosis_core/src/util/scale_manager.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

import 'subcontrollers/landmarks_controller.dart';
import 'subcontrollers/tracing_controller.dart';

class MainController {
  ScaleManager scaleManager;
  TracingController tracingController;
  LandmarksController landmarksController;
  OdontoradiosisKeeper infoKeeper;

  /// Constructor
  MainController(
    this.scaleManager,
    this.infoKeeper, {
    required TracingRepository tracingRepository,
    required LandmarkRepository landmarkRepository,
  })  : tracingController = TracingController(
          tracingRepository,
          scaleManager,
        ),
        landmarksController = LandmarksController(
          landmarkRepository,
          scaleManager,
        );

  /// Loads json file with landmarks location
  void loadJsonLandmarks(String jsonContent, [override = true]) {
    if (override) {
      // Load landmarks from default empty
      landmarksController.setLandmarks({});
    } else if (jsonContent.isNotEmpty) {
      // Load landmarks from json file
      landmarksController.loadLandmarks(jsonContent);
    }
  }

  /// Loads json file with bezier anatomical tracing points
  void loadJsonCurve(String jsonContent, [bool override = true]) {
    if (override) {
      // Load JsonCurves from default json file
      tracingController.setBezierPoints();
    } else if (jsonContent.isNotEmpty) {
      tracingController.loadBezierCurves(jsonContent);
    }
  }

  /// Save both tracing and landmarks
  void saveAll() {
    landmarksController.saveLandmarks();
    tracingController.saveBezierCurve();
  }

  /// Load landmarks and anatomical tracing points from storage or default
  void loadAll() {
    if (!landmarksController.loadLandmarks()) {
      print('Landmarks not found');
      loadJsonLandmarks('', true);
    }
    if (!tracingController.loadBezierCurves()) {
      print('Tracing not found');
      loadJsonCurve('', true);
    }
  }

  /// Change or set point location on current mouse position
  void markLandmarkPoint(String landmarkName, IPointBidimensional point) {
    if (landmarkName.isNotEmpty && landmarkName != 'Selecione') {
      final currentMousePosition = scaleManager.getMousePos(
        point,
      );
      landmarksController.setLandmark(
          landmarkName,
          ILandmark.create(
            x: currentMousePosition.x,
            y: currentMousePosition.y,
          ));

      landmarksController.saveLandmarks();
      landmarksController.redrawLandmarks();
    }
  }
}
