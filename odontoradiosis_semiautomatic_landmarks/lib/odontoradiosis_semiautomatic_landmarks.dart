library odontoradiosis_semiautomatic_landmarks;

import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';
import 'package:odontoradiosis_semiautomatic_landmarks/src/models/routine_description.dart';
import 'package:odontoradiosis_semiautomatic_landmarks/src/util/landmarks_manager.dart';

import 'src/controllers/routine_executor.dart';
import 'src/util/tracing_manager.dart';

export 'src/util/landmarks_manager.dart';
export 'src/util/tracing_manager.dart';

class SemiautomaticLandmarks {
  List<IRoutineDescription> routinesDescription;
  AbsTracingManager tracingController;
  AbsLandmarksManagement landmarksController;

  /// @param {array} routinesDescription Have all json data informing all routines
  /// @param {TracingController} tracingController
  /// @param {LandmarksController} landmarksController
  SemiautomaticLandmarks(
    this.routinesDescription,
    this.tracingController,
    this.landmarksController,
  );

  /// Start all routines
  bool start() {
    for (final currentRoutine in routinesDescription) {
      // Initialize access to curves, to make sure that the routine only accesses the curves it needs
      final accessedCurves = <String, ICurveAccess>{};
      for (final curveName in currentRoutine.accessed_curves) {
        final tracing = tracingController.getTracing(curveName);
        if (tracing != null) {
          accessedCurves[curveName] = tracing;
        }
      }

      final executor = RoutineExecutor(
        accessedCurves,
        landmarksController,
        currentRoutine,
      );
      executor.start();
    }
    landmarksController.redrawLandmarks();
    return true;
  }
}
