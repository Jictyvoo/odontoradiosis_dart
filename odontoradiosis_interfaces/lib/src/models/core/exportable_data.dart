import 'package:odontoradiosis_interfaces/src/interfaces/controllers/curve_manipulation.dart';
import 'package:odontoradiosis_interfaces/src/interfaces/controllers/landmark_manipulation.dart';

class IExportableData {
  final String imageData;
  final ILandmarkArray landmarks;
  final ITracingCurves curves;

  IExportableData(this.imageData, this.landmarks, this.curves);
}
