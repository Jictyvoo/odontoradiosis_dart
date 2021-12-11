import 'package:odontoradiosis_interfaces/src/models/bidimensional_point.dart';

class ICurvePointLocation extends IPointBidimensional {
  final List<double> element;

  const ICurvePointLocation(this.element, double xPosition, double yPosition)
      : super(xPosition, yPosition);
}
