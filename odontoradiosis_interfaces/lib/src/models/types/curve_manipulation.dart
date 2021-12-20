import '../bidimensional_point.dart';

typedef BezierChangeFunction = double Function(double point_1, double point_2);

typedef IBezierPoints = List<List<double>>;

abstract class ICurveAccess {
  IBezierPoints get points;

  IPointBidimensional? getPoint(int index);
}

typedef ITracingCurves = Map<String, IBezierPoints>;

typedef ITracingBezierList = List<IBezierPoints>;

typedef ITracingList = Map<String, ICurveAccess>;
