import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class ScaleValues {
  final double pointRadius;
  final double nameScale;
  final double lineWidth;
  final IPointBidimensional textRelativePosition;

  const ScaleValues({
    this.pointRadius = 2,
    this.nameScale = 10,
    this.lineWidth = 2,
    this.textRelativePosition = const IPointBidimensional(15, 15),
  });
}
