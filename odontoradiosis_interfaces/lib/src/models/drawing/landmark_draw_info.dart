import 'package:odontoradiosis_interfaces/src/interfaces/views/colors.dart';
import 'package:odontoradiosis_interfaces/src/models/types/landmark_manipulation.dart';

import '../bidimensional_point.dart';

class SpecificLandmarkInfo {
  final ILandmark point;
  final String name;
  final IPointBidimensional textPosition;
  final double maxTextWidth;

  const SpecificLandmarkInfo(
    this.point,
    this.name,
    this.textPosition, {
    this.maxTextWidth = 50,
  });
}

class LandmarkDrawInfo {
  final List<SpecificLandmarkInfo> landmarks;
  final double? pointRadius;
  final double? strokeWidth;
  final double? fontSize;
  final BiColors? color;

  const LandmarkDrawInfo({
    required this.landmarks,
    this.pointRadius,
    this.strokeWidth,
    this.fontSize,
    this.color,
  });
}
