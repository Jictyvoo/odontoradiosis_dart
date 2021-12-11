import 'package:odontoradiosis_interfaces/src/models/types/curve_manipulation.dart';

abstract class AbsTracingManager {
  ICurveAccess? getTracing(String curveName);
}
