import 'package:odontoradiosis_interfaces/src/models/box_dimensions.dart';
import 'package:odontoradiosis_interfaces/src/models/types/curve_manipulation.dart';

class TracingDrawInfo {
  final ITracingBezierList curvesList;
  final BoxDimensions? boxDimensions;
  final IBezierPoints? curvePoints;
  final int? color;

  const TracingDrawInfo(
    this.curvesList, {
    this.boxDimensions,
    this.color = 0xFF4AA336,
    this.curvePoints,
  });
}
