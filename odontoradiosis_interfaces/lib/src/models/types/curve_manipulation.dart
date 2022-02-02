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

class TracingCurveDefinition {
  /// The tracing name, that is human readable
  final String name;
  final String? _curveName;

  const TracingCurveDefinition(this.name, {String? curveName})
      : _curveName = curveName;

  /// Normalize name
  String _normalizeTracingName() {
    return name.replaceAll(' ', '-').toLowerCase();
  }

  String get curveName {
    return _curveName ?? _normalizeTracingName();
  }

  @override
  String toString() {
    return name;
  }
}
