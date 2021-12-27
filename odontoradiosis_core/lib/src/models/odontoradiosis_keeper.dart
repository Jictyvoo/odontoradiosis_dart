import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class OnBoxVertex {
  final bool isOn;
  final int index;

  const OnBoxVertex({required this.isOn, required this.index});
}

class ActiveControlOptions {
  String curve;
  String landmark;
  bool isAllCurves;

  ActiveControlOptions({
    this.curve = '',
    this.landmark = '',
    this.isAllCurves = false,
  });

  ActiveControlOptions.empty()
      : curve = '',
        landmark = '',
        isAllCurves = false;
}

class OdontoradiosisKeeper {
  bool isMouseDown;
  bool isInsideBox;
  OnBoxVertex isOnBoxVertex;
  ICurvePointLocation? isOnCurvePoints;
  IMousePosition mousePosition;
  bool isCurveFunction;
  ActiveControlOptions selectedOptions;

  /// Default constructor that sets all attributes to its default values
  OdontoradiosisKeeper({
    this.isMouseDown = false,
    this.isInsideBox = false,
    this.isOnBoxVertex = const OnBoxVertex(isOn: false, index: 0),
    this.isOnCurvePoints,
    this.mousePosition = const IMousePosition(x: 0, y: 0, disabled: true),
    this.isCurveFunction = false,
  }) : selectedOptions = ActiveControlOptions(
          curve: '',
          landmark: '',
          isAllCurves: false,
        );
}
