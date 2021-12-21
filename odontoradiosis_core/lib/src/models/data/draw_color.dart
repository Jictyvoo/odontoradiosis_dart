import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class DrawningColor implements BiColors {
  final int _primary;
  final int _secondary;

  const DrawningColor(this._primary, this._secondary);

  static const anatomicalTracing = DrawningColor(0xFF4AA336, 0xFF313399);

  @override
  int get primary => _primary;

  @override
  String get primaryStr => '#${_primary.toRadixString(16)}';

  @override
  int get secondary => _secondary;

  @override
  String get secondaryStr => '#${_secondary.toRadixString(16)}';
}
