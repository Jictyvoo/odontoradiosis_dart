import 'package:odontoradiosis/core/services/semiautomatic_landmarks_service.dart';
import 'package:odontoradiosis_core/odontoradiosis_core.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class CustomLateralCephalometricService extends LateralCephalometricService
    with SemiautomaticLandmarksService {
  CustomLateralCephalometricService(ImageRepository localRepository)
      : super(localRepository);
}
