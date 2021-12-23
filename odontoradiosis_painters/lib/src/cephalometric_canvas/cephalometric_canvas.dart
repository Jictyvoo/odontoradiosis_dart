import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
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
  ui.Image? _image;

  @override
  void initState() {
    super.initState();
  }

  Future<void> openImage([VoidCallbackFunction? loadFunction]) async {
    final completer = Completer<void>();
    // await Future.delayed(const Duration(seconds: 5));
    ui.decodeImageFromList(base64Decode(testImage), (result) {
      _image = result;
      if (loadFunction != null) {
        loadFunction();
      }
      completer.complete();
    });

    return completer.future;
  }

  Widget _buildMainCanvas() {
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
          LandmarkDrawInfo(
            landmarks: [
              SpecificLandmarkInfo(
                ILandmark.create(x: 50, y: 50),
                'name',
                const IPointBidimensional(30, 60),
              ),
            ],
          ),
          ImageDrawInfo(base64Decode(testImage)),
          _image,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: openImage(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return _buildMainCanvas();
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
