import 'package:odontoradiosis/core/services/semiautomatic_landmarks_service.dart';
import 'package:odontoradiosis_core/odontoradiosis_core.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class CustomLateralCephalometricService extends LateralCephalometricService
    with SemiautomaticLandmarksService {
  CustomLateralCephalometricService(
    ImageRepository imageRepository,
    TracingRepository tracingRepository,
    LandmarkRepository landmarkRepository,
  ) : super(imageRepository, tracingRepository, landmarkRepository);

  @override
  void loadImage(String imageData) {
    clearSemiautomaticLandmarks();
    super.loadImage(imageData);
  }
}
