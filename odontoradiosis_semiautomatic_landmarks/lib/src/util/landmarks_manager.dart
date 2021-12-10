import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

abstract class AbsLandmarksManagement {
  void redrawLandmarks();

  void setLandmark(String name, ILandmark value);

  ILandmarkArray getLandmarks();
}
