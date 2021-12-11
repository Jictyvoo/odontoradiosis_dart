library odontoradiosis_semiautomatic_landmarks;

import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

import 'src/controllers/routine_executor.dart';
import 'src/models/routine_description.dart';

// Export packages
export 'src/models/routine_description.dart';

class SemiautomaticLandmarks {
  final List<IRoutineDescription> routinesDescription;
  final AbsTracingManager tracingController;
  final AbsLandmarksManagement landmarksController;

  /// @param {array} routinesDescription Have all json data informing all routines
  /// @param {TracingController} tracingController
  /// @param {LandmarksController} landmarksController
  const SemiautomaticLandmarks(
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
