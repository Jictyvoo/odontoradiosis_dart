import 'package:odontoradiosis_core/src/models/data/rect_dimensions.dart';
import 'package:odontoradiosis_core/src/models/data/scales.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class ScaleManager implements IScalesController {
  @override
  int pointRadius;

  double lineWidth;

  double nameScale;

  @override
  IPointBidimensional textRelativePosition;

  final ScaleValues scaleDrawValue;

  /// Default constructor for scale manager, that sets all default scale values
  ScaleManager([
    this.scaleDrawValue = const ScaleValues(
      pointRadius: 4,
      nameScale: 10,
      lineWidth: 2,
      textRelativePosition: IPointBidimensional(15, 15),
    ),
  ])  : pointRadius = 4,
        lineWidth = 1,
        nameScale = 10,
        textRelativePosition = IPointBidimensional.create(x: 15, y: 15);

  /// Calculate the scale to make canvas dynamic and returns it
  @override
  double dynamicCanvasScale({
    double valueToResize = 1,
    bool isX = false,
    required CanvasRenderingContext2D context,
    required ClientRect clientRect,
  }) {
    final canvasDimensions = RectDimensions(
      width: clientRect.width,
      height: clientRect.height,
    );
    final imageDimensions = RectDimensions(
      width: context.canvas.width,
      height: context.canvas.height,
    );
    if (isX) {
      return ((imageDimensions.width * valueToResize) / canvasDimensions.width);
    } else {
      return ((imageDimensions.height * valueToResize) /
          canvasDimensions.height);
    }
  }

  /// Calculates all scales variables
  @override
  void calculateScales(HTMLCanvasElement canvas) {
    final rect = canvas.getBoundingClientRect();
    final context = canvas.getContext('2d');
    final imageDimensions = RectDimensions(
      width: context.canvas.width,
      height: context.canvas.height,
    );
    final isX = imageDimensions.width > imageDimensions.height;
    pointRadius = dynamicCanvasScale(
      valueToResize: scaleDrawValue.pointRadius,
      isX: isX,
      context: context,
      clientRect: rect,
    ).toInt();
    nameScale = dynamicCanvasScale(
      valueToResize: scaleDrawValue.nameScale,
      isX: isX,
      context: context,
      clientRect: rect,
    );
    lineWidth = dynamicCanvasScale(
      valueToResize: scaleDrawValue.lineWidth,
      isX: isX,
      context: context,
      clientRect: rect,
    );
    textRelativePosition = IPointBidimensional.create(
      x: dynamicCanvasScale(
        valueToResize: scaleDrawValue.textRelativePosition.x,
        isX: isX,
        context: context,
        clientRect: rect,
      ),
      y: dynamicCanvasScale(
        valueToResize: scaleDrawValue.textRelativePosition.y,
        isX: isX,
        context: context,
        clientRect: rect,
      ),
    );
  }

  /// Returns an object containing the relative mouse position in Canvas
  @override
  IPointBidimensional getMousePos(
    HTMLCanvasElement canvas,
    IPointBidimensional point,
  ) {
    final rect = canvas.getBoundingClientRect();
    final context = canvas.getContext('2d');
    return IPointBidimensional.create(
      x: dynamicCanvasScale(
        valueToResize: point.x - rect.left,
        isX: true,
        context: context,
        clientRect: rect,
      ),
      y: dynamicCanvasScale(
        valueToResize: point.y - rect.top,
        isX: false,
        context: context,
        clientRect: rect,
      ),
    );
  }
}
