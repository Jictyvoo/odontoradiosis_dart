library odontoradiosis_core;

import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

import 'src/controllers/image_effects.dart';
import 'src/controllers/main_controller.dart';
import 'src/controllers/subcontrollers/tracing_controller.dart';

export 'src/controllers/image_effects.dart';
export 'src/controllers/mouse_event_impl.dart';
export 'src/models/data/bezier_curves.dart';

class LateralCephalometricService {
  late MainController _mainController;
  final ImageEffects _imageEffects;
  final ICanvasImage _imageInfo;
  final ImageRepository _imageRepository;
  final TracingRepository _tracingRepository;
  final LandmarkRepository _landmarkRepository;

  LateralCephalometricService(
    this._imageRepository,
    this._tracingRepository,
    this._landmarkRepository,
  )   : _imageInfo = ICanvasImage(''),
        _imageEffects = ImageEffects() {
    final imageData = _imageRepository.get(EStorageKey.IMAGE_DATA.name);
    _imageInfo.imageData = imageData ?? '';
    _imageInfo.isLoaded = false;
    _imageInfo.isFromStorage = imageData?.isNotEmpty ?? false;
  }

  void init([
    MainController? mainController,
    ILayeredCanvas? canvas,
  ]) {
    _mainController = mainController ??
        MainController(
          tracingRepository: _tracingRepository,
          landmarkRepository: _landmarkRepository,
          layeredCanvas: canvas,
        );

    // Sets layer order if canvas was given
    canvas?.layerOrder = {"image": 0, "bezier": 1, "landmarks": 2};

    // After the initialization of the canvas, the loaded image is displayed
    if (_imageInfo.imageData.isNotEmpty) {
      openImageOnCanvas(_imageInfo.imageData);
      _imageInfo.isLoaded = true;
    }
  }

  void openImageOnCanvas(String imageData) {
    if (_imageInfo.isFromStorage) {
      _mainController.loadAll();
    } else {
      _mainController.loadJsonCurve('', true);
      _mainController.loadJsonLandmarks('', true);
      _mainController.saveAll();
    }

    _imageEffects.reset();
  }

  void loadImage(String imageData) {
    _imageInfo.imageData = imageData;
    _imageInfo.isFromStorage = false;
    // TODO: Add this line to child classes _semiautomaticLandmarks = null;
    // save the image data on local storage
    _imageRepository.set(EStorageKey.IMAGE_DATA.name, imageData);
    if (_imageInfo.isLoaded) {
      openImageOnCanvas(imageData);
    }
  }

  void loadExportedData(IExportableData exportedData) {
    _landmarkRepository.set(EStorageKey.LANDMARKS.name, exportedData.landmarks);
    _tracingRepository.set(EStorageKey.BEZIER_CURVES.name, exportedData.curves);
    loadImage(exportedData.imageData);
    _imageInfo.isFromStorage = true;
  }

  IExportableData exportCephalometricData() {
    return IExportableData(
      imageData: _imageInfo.imageData,
      landmarks: _mainController.landmarksController.landmarks,
      curves: _mainController.tracingController.curvePoints,
    );
  }

  ImageEffects get effectsManager {
    return _imageEffects;
  }

  TracingController get tracingController {
    return _mainController.tracingController;
  }

  MainController get controller {
    return _mainController;
  }

  bool get isImageOpened {
    return _imageInfo.imageData.isNotEmpty;
  }
}
