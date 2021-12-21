import 'package:flutter/widgets.dart';
import 'package:odontoradiosis_core/odontoradiosis_core.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

import 'cephalometric_painter.dart';

class CephalometricCanvas extends StatefulWidget {
  final MouseEventInteraction? mouseEvent;

  const CephalometricCanvas({Key? key, this.mouseEvent}) : super(key: key);

  @override
  _CephalometricCanvasState createState() => _CephalometricCanvasState();
}

class _CephalometricCanvasState extends State<CephalometricCanvas> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (details) {
        widget.mouseEvent?.onMouseDown(
          IPointBidimensional.create(
            x: details.localPosition.dx,
            y: details.localPosition.dy,
          ),
        );
        print('${details.globalPosition} - ${details.localPosition}');
      },
      onPanUpdate: (details) {
        print(details.delta);
      },
      child: CustomPaint(
        foregroundPainter: CephalometricPainter(
          TracingDrawInfo(
            DefaultBezierCurve.create().values.toList(),
            curvePoints: DefaultBezierCurve.create().values.toList().first,
          ),
          const LandmarkDrawInfo(landmarks: []),
        ),
        child: Image.network(
          '',
        ),
      ),
    );
  }
}
