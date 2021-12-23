import 'package:odontoradiosis_core/src/models/data/scales.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class ScaleManager {
  int pointRadius;
  double lineWidth;
  double nameScale;
  IPointBidimensional textRelativePosition;
  final ScaleValues scaleDrawValue;
  final IPointBidimensional _scales;

  /// Default constructor for scale manager, that sets all default scale values
  ScaleManager([
    this.scaleDrawValue = const ScaleValues(
      pointRadius: 4,
      nameScale: 10,
      lineWidth: 2,
      textRelativePosition: IPointBidimensional(15, 15),
    ),
    this._scales = const IPointBidimensional(0, 0),
  ])  : pointRadius = 4,
        lineWidth = 1,
        nameScale = 10,
        textRelativePosition = IPointBidimensional.create(x: 15, y: 15);

  /// Calculate the scale to make canvas dynamic and returns it
  double dynamicCanvasScale({
    double valueToResize = 1,
    bool isX = false,
  }) {
    if (isX) {
      return valueToResize * _scales.x;
    } else {
      return valueToResize * _scales.y;
    }
  }

  /// Calculates all scales variables
  void calculateScales() {
    final isX = _scales.x > _scales.y;
    pointRadius = dynamicCanvasScale(
      valueToResize: scaleDrawValue.pointRadius,
      isX: isX,
    ).toInt();
    nameScale = dynamicCanvasScale(
      valueToResize: scaleDrawValue.nameScale,
      isX: isX,
    );
    lineWidth = dynamicCanvasScale(
      valueToResize: scaleDrawValue.lineWidth,
      isX: isX,
    );
    textRelativePosition = IPointBidimensional.create(
      x: dynamicCanvasScale(
        valueToResize: scaleDrawValue.textRelativePosition.x,
        isX: isX,
      ),
      y: dynamicCanvasScale(
        valueToResize: scaleDrawValue.textRelativePosition.y,
        isX: isX,
      ),
    );
  }

  /// Returns an object containing the relative mouse position in Canvas
  IPointBidimensional getMousePos(
    IPointBidimensional point,
  ) {
    return IPointBidimensional.create(
      x: dynamicCanvasScale(
        valueToResize: point.x,
        isX: true,
      ),
      y: dynamicCanvasScale(
        valueToResize: point.y,
        isX: false,
      ),
    );
  }
}
