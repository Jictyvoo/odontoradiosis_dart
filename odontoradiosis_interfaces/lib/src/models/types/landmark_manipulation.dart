import 'package:odontoradiosis_interfaces/src/models/bidimensional_point.dart';

typedef ILandmark = IPointBidimensional;

typedef ILandmarkArray = Map<String, ILandmark>;

class LandmarkDefinition {
  final String name;
  final String acronym;

  const LandmarkDefinition(this.name, this.acronym);

  @override
  String toString() {
    return '$name ($acronym)';
  }
}
