import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

import 'cephalometric_painter.dart';

class CephalometricCanvas extends StatefulWidget {
  final MouseEventInteraction? mouseEvent;
  final TracingDrawInfo tracingDrawInfo;
  final LandmarkDrawInfo landmarkDrawInfo;
  final ImageDrawInfo imageDrawInfo;

  const CephalometricCanvas({
    Key? key,
    this.mouseEvent,
    required this.tracingDrawInfo,
    required this.landmarkDrawInfo,
    required this.imageDrawInfo,
  }) : super(key: key);

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
    ui.decodeImageFromList(widget.imageDrawInfo.imageData, (result) {
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
      onTapUp: (details) {
        print(details);
        widget.mouseEvent?.onMouseUp();
      },
      onPanUpdate: (details) {
        print(details.delta);
      },
      child: DecoratedBox(
        // FIXME: Needed to use decorated box because gesture detector was not working
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0x00ffffff)),
        ),
        child: CustomPaint(
          foregroundPainter: CephalometricPainter(
            widget.tracingDrawInfo,
            widget.landmarkDrawInfo,
            widget.imageDrawInfo,
            _image,
          ),
          child: const SizedBox.expand(),
        ),
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 8),
                  Text('Loading radiography image'),
                ],
              ),
            );
        }
      },
    );
  }
}
