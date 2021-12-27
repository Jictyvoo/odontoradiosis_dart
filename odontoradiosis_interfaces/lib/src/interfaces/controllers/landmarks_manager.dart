import 'package:odontoradiosis_interfaces/src/models/types/landmark_manipulation.dart';

abstract class AbsLandmarksManagement {
  void redrawLandmarks();

  void setLandmark(String name, ILandmark value);
}
