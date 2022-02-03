import 'package:odontoradiosis_core/src/models/data/scales.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class ScaleManagerImpl implements ScalesManager<ScaleValues> {
  int pointRadius;
  double lineWidth;
  double nameScale;
  IPointBidimensional textRelativePosition;
  final ScaleValues scaleDrawValue;
  final IPointBidimensional _scales;

  static const drawScales = ScaleValues(
    pointRadius: 4,
    nameScale: 10,
    lineWidth: 2,
    textRelativePosition: IPointBidimensional(15, 15),
  );

  /// Default constructor for scale manager, that sets all default scale values
  ScaleManagerImpl([
    this.scaleDrawValue = drawScales,
    this._scales = const IPointBidimensional(1, 1),
  ])  : pointRadius = 4,
        lineWidth = 1,
        nameScale = 10,
        textRelativePosition = IPointBidimensional.create(x: 15, y: 15);

  /// Calculate the scale to make canvas dynamic and returns it
  double _dynamicCanvasScale({
    double valueToResize = 1,
    bool isX = false,
  }) {
    if (isX) {
      return valueToResize * _scales.x;
    } else {
      return valueToResize * _scales.y;
    }
  }

  @override
  void calculateScales() {
    final isX = _scales.x > _scales.y;
    pointRadius = _dynamicCanvasScale(
      valueToResize: scaleDrawValue.pointRadius,
      isX: isX,
    ).toInt();
    nameScale = _dynamicCanvasScale(
      valueToResize: scaleDrawValue.nameScale,
      isX: isX,
    );
    lineWidth = _dynamicCanvasScale(
      valueToResize: scaleDrawValue.lineWidth,
      isX: isX,
    );
    textRelativePosition = IPointBidimensional.create(
      x: _dynamicCanvasScale(
        valueToResize: scaleDrawValue.textRelativePosition.x,
        isX: isX,
      ),
      y: _dynamicCanvasScale(
        valueToResize: scaleDrawValue.textRelativePosition.y,
        isX: isX,
      ),
    );
  }

  @override
  IPointBidimensional getMousePos(
    IPointBidimensional point,
  ) {
    return IPointBidimensional.create(
      x: _dynamicCanvasScale(
        valueToResize: point.x,
        isX: true,
      ),
      y: _dynamicCanvasScale(
        valueToResize: point.y,
        isX: false,
      ),
    );
  }

  @override
  ScaleValues get values => ScaleValues(
        pointRadius: pointRadius.toDouble(),
        nameScale: nameScale,
        lineWidth: lineWidth,
        textRelativePosition: textRelativePosition,
      );
}
