import 'dart:convert';

import 'package:odontoradiosis_core/src/models/data/draw_color.dart';
import 'package:odontoradiosis_core/src/util/string_helper.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class LandmarksController {
  ILandmarkArray _landmarks;
  final ICanvasDraw canvas;
  final LandmarkRepository _localRepository;
  static final DrawningColor _color = DrawningColor(
    fill: 'red',
    stroke: 0xFF330005,
  );

  /// Constructor
  LandmarksController(this.canvas, this._localRepository) : _landmarks = {};

  /// Returns this.landmarks
  ILandmarkArray get landmarks {
    return _landmarks;
  }

  /// Lardmarks setter
  void setLandmarks(ILandmarkArray newLandmarks) {
    _landmarks = newLandmarks;
  }

  /// Set a single landmark value
  void setLandmark(String name, [ILandmark value = const ILandmark(0, 0)]) {
    _landmarks[name] = value;
  }

  /// Verify if landmark exists. If not and toCreate is true, it'll create
  ILandmark verifyLandmark(String name, [bool toCreate = false]) {
    if (_landmarks[name] != null && toCreate) {
      _landmarks[name] = ILandmark.create(x: 0, y: 0);
    }
    return _landmarks[name] ?? const ILandmark(0, 0);
  }

  /// Save all landmarks in the given repository
  void saveLandmarks() {
    _localRepository.set(EStorageKey.LANDMARKS.name, _landmarks);
  }

  /// Load landmarks from local storage
  bool loadLandmarks([String jsonContent = '']) {
    ILandmarkArray decodedLandmarks = {};
    if (jsonContent.isNotEmpty) {
      decodedLandmarks = jsonDecode(jsonContent);
    } else {
      decodedLandmarks = _localRepository.get(EStorageKey.LANDMARKS.name) ?? {};
    }

    // Make sure object is really valid
    if (decodedLandmarks.keys.isNotEmpty) {
      final ILandmarkArray validLandmarks = {};
      for (final landmark in decodedLandmarks.entries) {
        final landmarkName = landmark.key;
        final landmarkPosition = landmark.value;

        validLandmarks[landmarkName] = ILandmark.create(
          x: landmarkPosition.x,
          y: landmarkPosition.y,
        );
      }
      setLandmarks(validLandmarks);

      return true;
    }
    return false;
  }

  /// Draw a landmark with its name
  void drawLandmark(String landmarkName) {
    final locations = _landmarks[landmarkName];
    final readyToShowName = StringHelper.valueBetweenParenthesis(landmarkName);
    if (locations != null && readyToShowName.isNotEmpty) {
      canvas.drawCircleCtx(
        ICanvasLayers.LANDMARKS.value,
        locations.x,
        locations.y,
        canvas.scales.pointRadius,
        1,
        _color.fill,
        _color.stroke.toString(),
      );
      canvas.drawText(
        ICanvasLayers.LANDMARKS.value,
        (locations.x - canvas.scales.textRelativePosition.x).floorToDouble(),
        (locations.y + canvas.scales.textRelativePosition.y).floorToDouble(),
        readyToShowName.toString(),
        1,
        _color.fill,
        _color.stroke.toString(),
      );
    }
  }

  /// Redraw all landmarks
  void redrawLandmarks() {
    canvas.clearCanvas(ICanvasLayers.LANDMARKS.value);
    for (final element in _landmarks.keys) {
      drawLandmark(element);
    }
  }
}
