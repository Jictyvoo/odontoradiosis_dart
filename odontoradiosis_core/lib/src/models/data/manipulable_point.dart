import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class ManipulablePoint implements IPointBidimensional {
  @override
  double x;

  @override
  double y;

  ManipulablePoint({this.x = 0, this.y = 0});
}
