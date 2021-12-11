import 'package:odontoradiosis_interfaces/src/models/types/curve_manipulation.dart';

class IChangeBezierPoint {
  final BezierChangeFunction x;
  final BezierChangeFunction y;

  const IChangeBezierPoint(this.x, this.y);
}
