import 'package:odontoradiosis_core/odontoradiosis_core.dart';
import 'package:odontoradiosis_semiautomatic_landmarks/odontoradiosis_semiautomatic_landmarks.dart';
import 'package:odontoradiosis_semiautomatic_landmarks/semiautomatic_routines.dart'
    as routines;

mixin SemiautomaticLandmarksService on CephalometricCanvasService {
  SemiautomaticLandmarks? _semiautomaticLandmarks;

  /// Adding the semiautomatic landmark identification feature
  void markSemiautomatic() {
    final semiautomaticLandmarks = _semiautomaticLandmarks ??
        SemiautomaticLandmarks(
          [
            routines.a,
            routines.b,
            routines.ena,
            routines.gnatio,
            routines.nasio,
            routines.sela,
            routines.palatoMole,
            routines.porio,
            routines.enp,
            routines.pogonio,
            routines.mento,
            routines.gonio,
            routines.pterigoide,
            routines.orbitale,
            routines.proNasal,
            routines.condilio,
            routines.pogonioMole,
            routines.fissuraPterigoMaxilar,
          ],
          tracingController,
          controller.landmarksController,
        );
    if (semiautomaticLandmarks.start()) {
      controller.landmarksController.saveLandmarks();
    }
  }
}
