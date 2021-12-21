import 'package:odontoradiosis_interfaces/src/interfaces/views/colors.dart';
import 'package:odontoradiosis_interfaces/src/models/box_dimensions.dart';
import 'package:odontoradiosis_interfaces/src/models/types/curve_manipulation.dart';

class TracingDrawInfo {
  final ITracingBezierList curvesList;
  final BoxDimensions? boxDimensions;
  final IBezierPoints? curvePoints;
  final double? curvePointRadius;
  final double? boxVertexRadius;
  final double? strokeWidth;
  final BiColors? curveColor;
  final BiColors? boxColor;

  const TracingDrawInfo(
    this.curvesList, {
    this.boxDimensions,
    this.curvePoints,
    this.curvePointRadius,
    this.boxVertexRadius,
    this.strokeWidth,
    this.curveColor,
    this.boxColor,
  });
}
