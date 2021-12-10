import 'package:odontoradiosis_interfaces/src/interfaces/controllers/curve_manipulation.dart';

class IChangeBezierPoint {
  final BezierChangeFunction x;
  final BezierChangeFunction y;

  IChangeBezierPoint(this.x, this.y);
}
