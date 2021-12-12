import 'dart:math' as math;

import 'package:odontoradiosis_core/src/util/useful_methods.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class AnatomicalTracingCurve implements ICurveAccess {
  final String _curveName;
  final IBezierPoints _curvePoints;
  List<IPointBidimensional> _boxPoints;
  List<double> _boxDimensions;

  AnatomicalTracingCurve(this._curveName, this._curvePoints)
      : _boxPoints = <IPointBidimensional>[],
        _boxDimensions = <double>[];

  /// Returns all edge points in a curve
  List<IPointBidimensional> getMaxMinPoints(bool recalculate) {
    if (_boxPoints.isNotEmpty && !recalculate) {
      return _boxPoints;
    }
    var minX = double.infinity, minY = double.infinity;
    var maxX = double.negativeInfinity, maxY = double.negativeInfinity;
    for (final element in _curvePoints) {
      for (var position = 0; position < element.length; position++) {
        final point = element[position];
        if (position % 2 != 0) {
          minY = math.min(minY, point);
          maxY = math.max(maxY, point);
        } else {
          minX = math.min(minX, point);
          maxX = math.max(maxX, point);
        }
      }
    }
    final minPoint = IPointBidimensional.create(
      x: minX,
      y: minY,
    );
    final maxPoint = IPointBidimensional.create(
      x: maxX,
      y: maxY,
    );
    _boxPoints = [minPoint, maxPoint];
    return _boxPoints;
  }

  /// Returns an array with box dimensions of a specific curve
  List<double> getBoxDimensions(
      [int borderSize = 20, bool recalculate = false]) {
    if (_boxDimensions.isNotEmpty && !recalculate) {
      return _boxDimensions;
    }
    final points = getMaxMinPoints(recalculate);
    return UsefulMethods.calculateBoxDimensions(points, borderSize);
  }

  IPointBidimensional _getCurveCenter([bool recalculate = false]) {
    final points = getMaxMinPoints(recalculate);
    final minPoint = points[0];
    final maxPoint = points[1];
    final center = IPointBidimensional.create(
      x: (minPoint.x + maxPoint.x) / 2,
      y: (minPoint.y + maxPoint.y) / 2,
    );
    return center;
  }

  /// Iterate all curves and changes it value
  void _runPointsAndChange(
    BezierChangeFunction callback_1,
    BezierChangeFunction callback_2,
  ) {
    for (final points in _curvePoints) {
      for (var position = 0; position < points.length; position++) {
        if (position % 2 == 0) {
          points[position] = callback_1(points[position], points[position + 1]);
        } else {
          points[position] = callback_2(points[position], points[position - 1]);
        }
      }
    }
    _boxDimensions = getBoxDimensions(20, true);
  }

  void updatePoints(
    BezierChangeFunction callback_1,
    BezierChangeFunction callback_2, [
    bool keepOldCenter = true,
  ]) {
    final IPointBidimensional previousCenter = _getCurveCenter(false);
    _runPointsAndChange(callback_1, callback_2);

    if (keepOldCenter) {
      final IPointBidimensional newCenter = _getCurveCenter(true);
      // Move curve to the old center
      final moveX = previousCenter.x - newCenter.x;
      final moveY = previousCenter.y - newCenter.y;
      _runPointsAndChange((pointX, _pointY) => pointX + moveX,
          (pointY, _pointX) => pointY + moveY);
    }
  }

  @override
  IPointBidimensional? getPoint(int index) {
    var counter = 0;
    // TODO: Improve this search, calculate position with index divisor
    for (final element in points) {
      for (var subindex = 1; subindex < element.length; subindex += 2) {
        counter++;
        if (counter == index) {
          return IPointBidimensional.create(
            x: element[subindex - 1],
            y: element[subindex],
          );
        }
      }
    }
    return null;
  }

  @override
  IBezierPoints get points {
    return _curvePoints;
  }

  int get length {
    return _curvePoints.length;
  }

  String get name {
    return _curveName;
  }
}
