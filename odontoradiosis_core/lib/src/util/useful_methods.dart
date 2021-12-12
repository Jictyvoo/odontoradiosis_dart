import 'dart:math' as math;

import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class UsefulMethods {
  /// Returns canvas style, based on parameters
  static String canvasStyle([
    int zIndex = 0,
    String position = 'absolute',
    int left = 0,
    int top = 0,
  ]) {
    return "position: $position; left: $left; top: $top; z-index: $zIndex;";
  }

  /// Normalize name
  static String normalizeTracingName(String toNormalize) {
    return toNormalize.replaceAll(' ', '-').toLowerCase();
  }

  /// Return scale to angle
  static int highLowAngle(
    IPointBidimensional oldPosition,
    IPointBidimensional currentPosition,
  ) {
    final maxX = (oldPosition.x - currentPosition.x).abs(),
        maxY = (oldPosition.y - currentPosition.y).abs();
    if (math.max(maxX, maxY) == maxX) {
      return oldPosition.x > currentPosition.x ? -1 : 1;
    }
    return oldPosition.y > currentPosition.y ? -1 : 1;
  }

  /// Calculate a dimesion for a rectangle box based on it's max and min points
  static List<double> calculateBoxDimensions(
    List<IPointBidimensional> points, [
    int borderSize = 20,
  ]) {
    final minPoint = points[0];
    final maxPoint = points[1];
    final width = maxPoint.x - minPoint.x, height = maxPoint.y - minPoint.y;
    return [
      minPoint.x - borderSize,
      minPoint.y - borderSize,
      width + borderSize * 2,
      height + borderSize * 2,
    ];
  }

  /// Subtract the origin from points
  static List<IPointBidimensional> normalizeValues(
    IPointBidimensional pointA,
    IPointBidimensional pointB,
    IPointBidimensional origin,
  ) {
    final normalized = [
      IPointBidimensional.create(
        x: pointA.x - origin.x,
        y: pointA.y - origin.y,
      ),
      IPointBidimensional.create(
        x: pointB.x - origin.x,
        y: pointB.y - origin.y,
      ),
    ];

    return normalized;
  }

  /// Calculate angle between two points
  static double calculateAngle(
    IPointBidimensional pointA,
    IPointBidimensional pointB,
  ) {
    final productModuleFirst = math.sqrt(
          math.pow(pointA.x, 2) + math.pow(pointA.y, 2),
        ),
        productModuleSecond = math.sqrt(
          math.pow(pointB.x, 2) + math.pow(pointB.y, 2),
        );
    final scaleProduct = (pointA.x * pointB.x + pointA.y * pointB.y).abs();
    return math.acos(scaleProduct / (productModuleFirst * productModuleSecond));
  }
}
