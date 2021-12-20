import 'package:odontoradiosis_core/src/controllers/main_controller.dart';
import 'package:odontoradiosis_core/src/controllers/subcontrollers/tracing_controller.dart';
import 'package:odontoradiosis_core/src/models/data/manipulable_point.dart';
import 'package:odontoradiosis_core/src/models/odontoradiosis_keeper.dart';
import 'package:odontoradiosis_core/src/util/scale_manager.dart';
import 'package:odontoradiosis_core/src/util/useful_methods.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class MouseEventImpl implements MouseEventInteraction {
  final TracingController _tracingController;
  final ILayeredCanvas _canvasController;
  final MainController _controller;
  final OdontoradiosisKeeper _infoKeeper;
  final ScaleManager _scaleManager;

  const MouseEventImpl(
    this._tracingController,
    this._canvasController,
    this._controller,
    this._infoKeeper,
    this._scaleManager,
  );

  void _moveBoxVertex(
    final IPointBidimensional currentPosition,
    final OnBoxVertex boxVertexInfo,
    final String curveName,
  ) {
    final scales = ManipulablePoint(
      x: currentPosition.x / _infoKeeper.mousePosition.x,
      y: currentPosition.y / _infoKeeper.mousePosition.y,
    );
    if (boxVertexInfo.index < 2) {
      scales.x = _infoKeeper.mousePosition.x / currentPosition.x;
    }
    if (boxVertexInfo.index % 2 == 0) {
      scales.y = _infoKeeper.mousePosition.y / currentPosition.y;
    }

    // TODO: Make scales be attached with one of the points. This way maybe the edge selected can follow the mouse.
    if (_infoKeeper.selectedOptions.isAllCurves) {
      _tracingController.rescaleAllCurves(scales);
    } else {
      _tracingController.rescaleBezier(curveName, scales.x, scales.y);
    }
  }

  void _translateCurvePoints(final IPointBidimensional currentPosition) {
    final curveSelection = _infoKeeper.isOnCurvePoints;
    if (curveSelection != null) {
      final curvePoints = curveSelection.element;
      curvePoints[curveSelection.x] -=
          _infoKeeper.mousePosition.x - currentPosition.x;
      curvePoints[curveSelection.y] -=
          _infoKeeper.mousePosition.y - currentPosition.y;
    }
  }

  void _translateEntireCurve(
    final IPointBidimensional currentPosition,
    final String curveName,
  ) {
    final movement = IPointBidimensional.create(
      x: _infoKeeper.mousePosition.x - currentPosition.x,
      y: _infoKeeper.mousePosition.y - currentPosition.y,
    );
    if (_infoKeeper.selectedOptions.isAllCurves) {
      _tracingController.translateAllCurves(movement);
    } else {
      _tracingController.translateBezier(
        curveName,
        movement.x,
        movement.y,
      );
    }
  }

  void _rotateDuringMove(
    final IPointBidimensional currentPosition,
    final String curveName,
  ) {
    var angle = UsefulMethods.calculateAngle(
      currentPosition,
      _infoKeeper.mousePosition,
    );
    if (!angle.isNaN) {
      angle *= UsefulMethods.highLowAngle(
        _infoKeeper.mousePosition,
        IPointBidimensional.create(
          x: currentPosition.x,
          y: currentPosition.y,
        ),
      );
      _tracingController.rotateBezier(curveName, angle);
    }
  }

  void _moveInStates(
    final IPointBidimensional currentPosition,
    final String curveName,
  ) {
    if (_infoKeeper.isOnBoxVertex.isOn) {
      // Apply functions when mouse on box vertex
      _moveBoxVertex(currentPosition, _infoKeeper.isOnBoxVertex, curveName);
    } else if (_infoKeeper.isOnCurvePoints != null) {
      // Translate the curve points directly
      _translateCurvePoints(currentPosition);
    } else if (_infoKeeper.isInsideBox) {
      _translateEntireCurve(currentPosition, curveName);
    } else {
      // Rotate selected curve based on mouse position difference
      _rotateDuringMove(currentPosition, curveName);
    }
    _infoKeeper.mousePosition = IMousePosition(
      x: currentPosition.x,
      y: currentPosition.y,
      disabled: false,
    );

    _tracingController.drawAllCurves();
    if (_infoKeeper.selectedOptions.isAllCurves) {
      _tracingController.drawEntireCurveBox(true);
    } else {
      _tracingController.drawCurveBox(curveName, true);
      _tracingController.drawPointCircle(curveName);
    }
  }

  @override
  void onMouseMove(final IPointBidimensional currentPosition) {
    if (_infoKeeper.isMouseDown && _infoKeeper.isCurveFunction) {
      /* do drag things */
      _canvasController.canvasCursor = 'move';

      final curveName = _infoKeeper.selectedOptions.curve;

      if (_infoKeeper.mousePosition.disabled) {
        _infoKeeper.mousePosition = IMousePosition(
          x: currentPosition.x,
          y: currentPosition.y,
          disabled: false,
        );
      } else {
        // Check conditions to change the state of movement on canvas
        _moveInStates(currentPosition, curveName);
      }
    } else if (_infoKeeper.isCurveFunction) {
      _canvasController.canvasCursor = 'crosshair';
    }
  }

  @override
  void onMouseDown(IPointBidimensional event) {
    _infoKeeper.isMouseDown = true;

    // Start handling the mouse position
    final curveName = _infoKeeper.selectedOptions.curve;
    if (curveName.isEmpty || curveName == 'selecione') {
      _infoKeeper.isCurveFunction = false;
      final landmarkName = _infoKeeper.selectedOptions.landmark;
      _controller.markLandmarkPoint(
        landmarkName,
        IPointBidimensional.create(
          x: event.x,
          y: event.y,
        ),
      );
    } else if (_tracingController.curveExists(curveName) ||
        _infoKeeper.selectedOptions.isAllCurves) {
      _infoKeeper.isCurveFunction = true;
      final relativeMouse = _scaleManager.getMousePos(
        IPointBidimensional.create(x: event.x, y: event.y),
      );
      _infoKeeper.isInsideBox = _tracingController.verifyMouseInBox(
        relativeMouse,
        curveName,
        _infoKeeper.selectedOptions.isAllCurves,
      );

      _infoKeeper.isOnBoxVertex = _tracingController.verifyMouseOnBoxVertex(
        relativeMouse,
        curveName,
        _infoKeeper.selectedOptions.isAllCurves,
      );
      _infoKeeper.isOnCurvePoints = _tracingController.verifyMouseOnCurvePoint(
        relativeMouse,
        curveName,
      );
    }
  }

  @override
  void onMouseUp() {
    _infoKeeper.isMouseDown = false;
    _infoKeeper.isInsideBox = false;
    _infoKeeper.isOnBoxVertex = const OnBoxVertex(isOn: false, index: 0);
    _infoKeeper.isOnCurvePoints = null;

    _infoKeeper.mousePosition = const IMousePosition(disabled: true);
    _tracingController.saveBezierCurve();
  }
}
