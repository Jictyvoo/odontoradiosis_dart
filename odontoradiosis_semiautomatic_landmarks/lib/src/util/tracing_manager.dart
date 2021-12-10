import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

abstract class AbsTracingManager {
  ICurveAccess? getTracing(String curveName);
}
