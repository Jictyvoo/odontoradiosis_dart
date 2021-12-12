import 'package:odontoradiosis_interfaces/src/models/bidimensional_point.dart';

class ICurvePointLocation extends IPointBidimensional {
  final List<double> element;

  const ICurvePointLocation({
    required this.element,
    required double x,
    required double y,
  }) : super(x, y);
}
