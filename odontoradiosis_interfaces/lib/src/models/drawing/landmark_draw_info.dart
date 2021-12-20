import 'package:odontoradiosis_interfaces/src/models/types/landmark_manipulation.dart';

import '../bidimensional_point.dart';

class LandmarkDrawInfo {
  final ILandmark point;
  final int pointRadius;
  final String name;
  final IPointBidimensional textPosition;

  const LandmarkDrawInfo(
    this.point,
    this.pointRadius,
    this.name,
    this.textPosition,
  );
}
