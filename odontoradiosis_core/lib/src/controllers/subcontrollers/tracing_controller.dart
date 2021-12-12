import 'dart:convert';
import 'dart:math' as math;

import 'package:odontoradiosis_core/src/models/business/tracing_curve.dart';
import 'package:odontoradiosis_core/src/models/data/bezier_curves.dart';
import 'package:odontoradiosis_core/src/models/data/manipulable_point.dart';
import 'package:odontoradiosis_core/src/models/odontoradiosis_keeper.dart';
import 'package:odontoradiosis_core/src/util/useful_methods.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

import 'abstract_bezier_controller.dart';

class TracingController extends AbstractBezierController {
  ICanvasDraw canvasOdontoradiosis;
  ITracingDraw anatomicalTracing;
  Map<String, AnatomicalTracingCurve> bezierPoints;
  final TracingRepository _localRepository;

  /// Constructor
  TracingController(
    this.canvasOdontoradiosis,
    this.anatomicalTracing,
    this._localRepository,
  ) : bezierPoints = TracingController._bezierPoints2TracingList(
          DefaultBezierCurve.create(),
        );

  static Map<String, AnatomicalTracingCurve> _bezierPoints2TracingList(
    ITracingCurves bezierPoints,
  ) {
    final tracingList = <String, AnatomicalTracingCurve>{};

    for (final entry in bezierPoints.entries) {
      tracingList[entry.key] = AnatomicalTracingCurve(entry.key, entry.value);
    }

    return tracingList;
  }

  static ITracingCurves _tracingList2BezierPoints(ITracingList tracingList) {
    final ITracingCurves bezierPoints = {};
    for (final entry in tracingList.entries) {
      bezierPoints[entry.key] = entry.value.points;
    }
    return bezierPoints;
  }

  /// Bezier points setter
  void setBezierPoints([ITracingCurves? points]) {
    bezierPoints = TracingController._bezierPoints2TracingList(
        points ?? DefaultBezierCurve.create());
  }

  /// Verify if curve exists
  bool curveExists(String curveId) {
    return bezierPoints.containsKey(curveId);
  }

  ITracingCurves get curvePoints {
    return TracingController._tracingList2BezierPoints(bezierPoints);
  }

  /// Verify if curve exists and returns it or null
  IBezierPoints? getCurvePoints(String curveId) {
    if (curveExists(curveId)) {
      return bezierPoints[curveId]?.points;
    }
    return null;
  }

  @override
  AnatomicalTracingCurve? getTracing(String curveName) {
    if (curveExists(curveName)) {
      return bezierPoints[curveName];
    }
    return null;
  }

  /// Save all bezier curves in a given repository
  void saveBezierCurve() {
    _localRepository.set(
      EStorageKey.BEZIER_CURVES.name,
      TracingController._tracingList2BezierPoints(bezierPoints),
    );
  }

  /// Load bezier curves from repository
  bool loadBezierCurves([String jsonContent = '']) {
    ITracingCurves decodedCurves = {};
    if (jsonContent.isNotEmpty) {
      decodedCurves = jsonDecode(jsonContent);
    } else {
      decodedCurves =
          _localRepository.get(EStorageKey.BEZIER_CURVES.name) ?? {};
    }

    // Save parsed curves in bezierPoints
    if (decodedCurves.isNotEmpty) {
      setBezierPoints(decodedCurves);
      return true;
    }
    return false;
  }

  /// Call AnatomicalTracing method to draw bezierCurves
  void drawAllCurves() {
    anatomicalTracing.clearCanvas();
    for (final entry in bezierPoints.entries) {
      final element = entry.value;
      anatomicalTracing.drawCurve(element.points);
    }
  }

  /// Draw Curve box
  void drawCurveBox(String currentCurve, bool recalculate) {
    final tracing = getTracing(currentCurve);
    if (tracing != null) {
      anatomicalTracing.drawCurveBox(tracing.getBoxDimensions(20, recalculate));
    }
  }

  List<IPointBidimensional> _getMaxMinAllCurves(bool recalculate) {
    // get the max and min points of all curves
    final maxPoints = ManipulablePoint(
      x: double.negativeInfinity,
      y: double.negativeInfinity,
    );
    final minPoints = ManipulablePoint(
      x: double.infinity,
      y: double.infinity,
    );
    for (final curveElement in bezierPoints.values) {
      final maxMinPoints = curveElement.getMaxMinPoints(recalculate);
      // Override max point
      maxPoints.x = math.max(maxMinPoints[1].x, maxPoints.x);
      maxPoints.y = math.max(maxMinPoints[1].y, maxPoints.y);

      // Override min point
      minPoints.x = math.min(maxMinPoints[0].x, minPoints.x);
      minPoints.y = math.min(maxMinPoints[0].y, minPoints.y);
    }
    return [minPoints, maxPoints];
  }

  void drawEntireCurveBox(bool recalculate) {
    final points = _getMaxMinAllCurves(recalculate);
    final boxDimensions = UsefulMethods.calculateBoxDimensions(points);
    anatomicalTracing.drawCurveBox(boxDimensions);
  }

  /// Draw all control points in a given curve
  void drawPointCircle(String curveName) {
    final tracing = getTracing(curveName);
    if (tracing != null) {
      anatomicalTracing.drawPointCircle(tracing.points);
    }
  }

  /// Returns a object containing a boolean if is on a boxVertex, and it index
  OnBoxVertex verifyMouseOnBoxVertex(
    IPointBidimensional relativeMouse,
    String curveName, [
    bool isAllCurves = false,
  ]) {
    var isOn = false;
    var vertexIndex = 0;

    final tracing = getTracing(curveName);
    var boxVertex = tracing?.getBoxDimensions(20, true) ?? [];
    if (isAllCurves) {
      boxVertex =
          UsefulMethods.calculateBoxDimensions(_getMaxMinAllCurves(true));
    }
    if (boxVertex.isEmpty) {
      return OnBoxVertex(isOn: isOn, index: vertexIndex);
    }

    final pointRadius = canvasOdontoradiosis.scales.pointRadius;

    var index = 0;
    for (var element in [
      [boxVertex[0], boxVertex[1]],
      [boxVertex[0], boxVertex[1] + boxVertex[3]],
      [boxVertex[0] + boxVertex[2], boxVertex[1]],
      [boxVertex[0] + boxVertex[2], boxVertex[1] + boxVertex[3]],
    ]) {
      if (relativeMouse.x >= element[0] - pointRadius &&
          relativeMouse.x <= element[0] + pointRadius &&
          relativeMouse.y >= element[1] - pointRadius &&
          relativeMouse.y <= element[1] + pointRadius) {
        isOn = true;
        vertexIndex = index;
      }
      index++;
    }
    return OnBoxVertex(isOn: isOn, index: vertexIndex);
  }

  /// Returns a boolean informing if the mouse is inside the box that contains the curve
  bool verifyMouseInBox(
    IPointBidimensional relativeMouse,
    String curveName, [
    bool isAllCurves = false,
  ]) {
    var points = <double>[];
    if (isAllCurves) {
      final maxMin = _getMaxMinAllCurves(true);
      points = UsefulMethods.calculateBoxDimensions(maxMin);
    }

    final tracing = getTracing(curveName);
    if (tracing != null) {
      points = tracing.getBoxDimensions();
    }

    // Verify if mouse is inside the box only has valid points
    if (points.length >= 4) {
      return (relativeMouse.x >= points[0] &&
          relativeMouse.x <= points[0] + points[2] &&
          relativeMouse.y >= points[1] &&
          relativeMouse.y <= points[1] + points[3]);
    }
    return false;
  }

  /// Returns the current position of the mouse if it is on a curve point
  ICurvePointLocation? verifyMouseOnCurvePoint(
      IPointBidimensional relativeMouse, String curveName) {
    final pointRadius = canvasOdontoradiosis.scales.pointRadius;
    final tracing = getTracing(curveName);
    if (tracing == null) {
      return null;
    }
    for (var index = 0; index < tracing.length; index++) {
      final element = tracing.points[index];
      for (var subIndex = 0; subIndex < element.length; subIndex += 2) {
        if (relativeMouse.x >= element[subIndex] - pointRadius &&
            relativeMouse.x <= element[subIndex] + pointRadius &&
            relativeMouse.y >= element[subIndex + 1] - pointRadius &&
            relativeMouse.y <= element[subIndex + 1] + pointRadius) {
          return ICurvePointLocation(
            element: element,
            x: subIndex.toDouble(),
            y: subIndex + 1,
          );
        }
      }
    }
    return null;
  }

  rescaleAllCurves(IPointBidimensional scales) {
    for (final curveName in bezierPoints.keys) {
      rescaleBezier(curveName, scales.x, scales.y);
    }
  }

  translateAllCurves(IPointBidimensional movement) {
    for (final curveName in bezierPoints.keys) {
      translateBezier(curveName, movement.x, movement.y);
    }
  }
}
