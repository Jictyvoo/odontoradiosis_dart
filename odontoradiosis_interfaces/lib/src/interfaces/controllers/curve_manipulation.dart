import 'curve_access.dart';

typedef BezierChangeFunction = double Function(double point_1, double point_2);

typedef IBezierPoints = List<List<double>>;

typedef ITracingCurves = Map<String, IBezierPoints>;

typedef ITracingList = Map<String, ICurveAccess>;
