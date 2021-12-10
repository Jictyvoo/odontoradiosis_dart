import 'package:odontoradiosis_interfaces/src/models/bidimensional_point.dart';

import 'curve_manipulation.dart';

abstract class ICurveAccess {
  IBezierPoints get points;

  IPointBidimensional? getPoint(int index);
}
