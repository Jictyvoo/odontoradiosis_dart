import 'package:odontoradiosis_interfaces/src/models/bidimensional_point.dart';

abstract class ScalesManager<T> {
  /// Calculates all scales variables
  void calculateScales();

  /// Return calculated dynamic scale values
  T get values;

  /// Returns an object containing the relative mouse position in Canvas
  IPointBidimensional getMousePos(
    IPointBidimensional point,
  );
}
