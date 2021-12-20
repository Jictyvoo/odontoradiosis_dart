import 'dart:convert';

import 'package:odontoradiosis_core/src/models/data/draw_color.dart';
import 'package:odontoradiosis_core/src/util/scale_manager.dart';
import 'package:odontoradiosis_core/src/util/string_helper.dart';
import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

class LandmarksController {
  ILandmarkArray _landmarks;
  final LandmarkRepository _localRepository;
  final ScaleManager _scales;
  static final DrawningColor _color = DrawningColor(
    fill: 'red',
    stroke: 0xFF330005,
  );

  /// Constructor
  LandmarksController(this._localRepository, this._scales) : _landmarks = {};

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
  LandmarkDrawInfo? prepareLandmark(
    String landmarkName,
    final IPointBidimensional locations,
  ) {
    final readyToShowName = StringHelper.valueBetweenParenthesis(landmarkName);
    if (readyToShowName.isNotEmpty) {
      return LandmarkDrawInfo(
        locations,
        _scales.pointRadius,
        readyToShowName,
        IPointBidimensional.create(
          x: (locations.x - _scales.textRelativePosition.x).floorToDouble(),
          y: (locations.y + _scales.textRelativePosition.y).floorToDouble(),
        ),
      );
    }
    return null;
  }

  /// Redraw all landmarks
  void redrawLandmarks() {
    // TODO: call setState/redraw
  }

  List<LandmarkDrawInfo> get landmarksInfo {
    final landmarkList = <LandmarkDrawInfo>[];
    for (final element in _landmarks.entries) {
      final prepared = prepareLandmark(element.key, element.value);
      if (prepared != null) {
        landmarkList.add(prepared);
      }
    }
    return landmarkList;
  }
}
