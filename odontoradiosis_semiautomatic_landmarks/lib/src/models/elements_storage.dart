import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class ElementsStorage {
  final Map<String, IPointBidimensional> _points;
  final Map<String, String> _strings;
  final Map<String, double> _numbers;
  final Map<String, ICurveAccess> _curveAccess;

  ElementsStorage()
      : _points = <String, IPointBidimensional>{},
        _strings = <String, String>{},
        _numbers = <String, double>{},
        _curveAccess = <String, ICurveAccess>{};

  void addPoint(String key, IPointBidimensional value) {
    _points[key] = value;
  }

  void addString(String key, String value) {
    _strings[key] = value;
  }

  void addNumber(String key, double value) {
    _numbers[key] = value;
  }

  void addCurveAccess(String key, ICurveAccess value) {
    _curveAccess[key] = value;
  }

  IPointBidimensional? getPoint(String key) {
    return _points[key];
  }

  String? getString(String key) {
    return _strings[key];
  }

  double? getNumber(String key) {
    // FIXME: This is a workaround since pre-defined functions only accept strings
    final tryFloat = double.tryParse(key);
    if (tryFloat != null) {
      return tryFloat;
    }
    return _numbers[key];
  }

  IPointBidimensional? getCurvePoint(String key, int index) {
    final curveElement = _curveAccess[key];
    if (curveElement != null) {
      return curveElement.getPoint(index);
    }
    return null;
  }
}
