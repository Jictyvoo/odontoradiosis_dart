import 'bidimensional_point.dart';

class IMousePosition extends IPointBidimensional {
  final bool disabled;

  const IMousePosition({required this.disabled, double x = 0, double y = 0})
      : super(x, y);
}
