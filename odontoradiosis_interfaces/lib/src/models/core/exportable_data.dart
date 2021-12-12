import 'package:odontoradiosis_interfaces/src/models/types/curve_manipulation.dart';
import 'package:odontoradiosis_interfaces/src/models/types/landmark_manipulation.dart';

class IExportableData {
  final String imageData;
  final ILandmarkArray landmarks;
  final ITracingCurves curves;

  const IExportableData({
    this.imageData = '',
    this.landmarks = const {},
    this.curves = const {},
  });
}
