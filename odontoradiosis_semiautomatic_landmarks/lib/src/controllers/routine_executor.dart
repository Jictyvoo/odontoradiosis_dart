import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';
import 'package:odontoradiosis_semiautomatic_landmarks/src/models/2d_point_keys.dart';
import 'package:odontoradiosis_semiautomatic_landmarks/src/models/elements_storage.dart';
import 'package:odontoradiosis_semiautomatic_landmarks/src/models/mutable_2d_point.dart';
import 'package:odontoradiosis_semiautomatic_landmarks/src/models/routine_description.dart';

class RoutineExecutor {
  final IRoutineDescription _routine;
  final ElementsStorage _elementsStorage;
  final Map<String, ICurveAccess> _accessedTracings;
  final AbsLandmarksManagement _landmarksController;

  RoutineExecutor(
    this._accessedTracings,
    this._landmarksController,
    this._routine,
  ) : _elementsStorage = ElementsStorage();

  void _loadCurve(String firstParam, String resultName) {
    final loadedCurves = _accessedTracings[firstParam];

    if (loadedCurves != null) {
      _elementsStorage.addCurveAccess(resultName, loadedCurves);
    }
  }

  void _accessPoint(int pointIndex, String tracingKey, String resultName) {
    final point = _elementsStorage.getCurvePoint(tracingKey, pointIndex);

    // Save obtained point if it exists
    if (point != null) {
      _elementsStorage.addPoint(resultName, point);
    }
  }

  void _pointToVar(String firstParam, IPointKeys resultName) {
    final toVar = _elementsStorage.getPoint(firstParam);
    if (toVar != null) {
      _elementsStorage.addNumber(resultName.x, toVar.x);
      _elementsStorage.addNumber(resultName.y, toVar.y);
    }
  }

  double _add(String firstParam, String secondParam, String resultName) {
    final value_1 = _elementsStorage.getNumber(firstParam) ?? 0;
    final value_2 = _elementsStorage.getNumber(secondParam) ?? 0;
    final result = value_1 + value_2;
    _elementsStorage.addNumber(resultName, result);
    return result;
  }

  double _sub(String firstParam, String secondParam, String resultName) {
    final value_1 = _elementsStorage.getNumber(firstParam) ?? 0;
    final value_2 = _elementsStorage.getNumber(secondParam) ?? 0;
    final result = value_1 - value_2;
    _elementsStorage.addNumber(resultName, result);
    return result;
  }

  double _div(String firstParam, String secondParam, String resultName) {
    final value_1 = _elementsStorage.getNumber(firstParam) ?? 0;
    final value_2 = _elementsStorage.getNumber(secondParam) ?? 0;
    final result = value_1 / value_2;
    _elementsStorage.addNumber(resultName, result);
    return result;
  }

  double _mul(String firstParam, String secondParam, String resultName) {
    final value_1 = _elementsStorage.getNumber(firstParam) ?? 0;
    final value_2 = _elementsStorage.getNumber(secondParam) ?? 0;
    final result = value_1 * value_2;
    _elementsStorage.addNumber(resultName, result);
    return result;
  }

  double _mod(String firstParam, String secondParam, String resultName) {
    final value_1 = _elementsStorage.getNumber(firstParam) ?? 0;
    final value_2 = _elementsStorage.getNumber(secondParam) ?? 0;
    final result = value_1 % value_2;
    _elementsStorage.addNumber(resultName, result);
    return result;
  }

  IPointBidimensional _average(List<String> firstParam, String resultName) {
    final average = Manipulable2dPoint(x: 0, y: 0);
    final total = firstParam.length;
    for (final element in firstParam) {
      final tempPoint = _elementsStorage.getPoint(element);
      if (tempPoint != null) {
        average.x += tempPoint.x;
        average.y += tempPoint.y;
      }
    }
    final resultPoint = Manipulable2dPoint(
      x: average.x / total,
      y: average.y / total,
    );

    _elementsStorage.addPoint(resultName, resultPoint);
    return resultPoint;
  }

  IPointBidimensional _returnPoint(String firstParam, String secondParam) {
    final result = IPointBidimensional.create(
      x: _elementsStorage.getNumber(firstParam) ?? 0,
      y: _elementsStorage.getNumber(secondParam) ?? 0,
    );
    _landmarksController.setLandmark(_routine.landmark, result);
    return result;
  }

  /// Start all routines
  IPointBidimensional? start() {
    for (final element in _routine.instructions) {
      // Saving elements in temp variables, to help with the execution of the routine
      final functionName = element[0];
      final firstParam = element[1];
      final secondParam = element[2];
      final resultName = element[3];

      // Select the function to execute
      switch (functionName) {
        case 'load_curve':
          _loadCurve(firstParam, resultName);
          break;
        case 'access_point':
          _accessPoint(firstParam, secondParam, resultName);
          break;
        case 'point_to_var':
          _pointToVar(
            firstParam,
            IPointKeys(x: resultName.x ?? 'x', y: resultName.y ?? 'y'),
          );
          break;
        case 'add':
          _add(firstParam, secondParam, resultName);
          break;
        case 'sub':
          _sub(firstParam, secondParam, resultName);
          break;
        case 'div':
          _div(firstParam, secondParam, resultName);
          break;
        case 'mul':
          _mul(firstParam, secondParam, resultName);
          break;
        case 'mod':
          _mod(firstParam, secondParam, resultName);
          break;
        case 'average':
          _average(firstParam, resultName);
          break;
        case 'return':
          return _returnPoint(firstParam, secondParam);
        default:
          throw ('Unknown routine');
      }
    }

    return null;
  }
}
