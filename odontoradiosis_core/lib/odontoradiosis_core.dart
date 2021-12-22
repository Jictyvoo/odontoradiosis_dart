library odontoradiosis_core;

import 'package:odontoradiosis_interfaces/odontoradiosis_interfaces.dart';

import 'src/controllers/image_effects.dart';
import 'src/controllers/main_controller.dart';
import 'src/controllers/subcontrollers/tracing_controller.dart';

export 'src/controllers/image_effects.dart';
export 'src/controllers/mouse_event_impl.dart';
export 'src/models/data/bezier_curves.dart';

class CephalometricCanvasService {
  late MainController _mainController;
  final ImageEffects _imageEffects;
  final ICanvasImage _imageInfo;
  final ILocalRepository _localRepository;

  CephalometricCanvasService(
    this._localRepository,
  )   : _imageInfo = ICanvasImage(''),
        _imageEffects = ImageEffects() {
    final imageData = _localRepository.get(EStorageKey.IMAGE_DATA.name);
    _imageInfo.imageData = imageData ?? '';
    _imageInfo.isLoaded = false;
    _imageInfo.isFromStorage = imageData?.isNotEmpty ?? false;
  }

  void init(
    ILayeredCanvas canvas,
    MainController mainController,
  ) {
    _mainController = mainController;

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
    _localRepository.set(EStorageKey.IMAGE_DATA.name, imageData);
    if (_imageInfo.isLoaded) {
      openImageOnCanvas(imageData);
    }
  }

  void loadExportedData(IExportableData exportedData) {
    _localRepository.set(EStorageKey.LANDMARKS.name, exportedData.landmarks);
    _localRepository.set(EStorageKey.BEZIER_CURVES.name, exportedData.curves);
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

  /// Adding the semiautomatic landmark indentification feature
  /*void markSemiautomatic() {
        final semiautomaticLandmarks =
            this._semiautomaticLandmarks ??
            SemiautomaticLandmarks(
                [
                    routines.a,
                    routines.b,
                    routines.ena,
                    routines.gnatio,
                    routines.nasio,
                    routines.sela,
                    routines.palatoMole,
                    routines.porio,
                    routines.enp,
                    routines.pogonio,
                    routines.mento,
                    routines.gonio,
                    routines.pterigoide,
                    routines.orbitale,
                    routines.proNasal,
                    routines.condilio,
                    routines.pogonioMole,
                    routines.fissuraPterigoMaxilar,
                ],
                this._tracingController,
                this._mainController.landmarksController
            );
        if (semiautomaticLandmarks.start()) {
            this._mainController.landmarksController.saveLandmarks();
        }
    }*/

  ImageEffects get effectsManager {
    return _imageEffects;
  }

  IEffectValues get defaultEffectValues {
    return ImageEffects.defaultValues;
  }

  TracingController get tracingController {
    return _mainController.tracingController;
  }

  MainController get controller {
    return _mainController;
  }

  bool get isImageOpened {
    return _imageInfo.imageData.length > 0;
  }
}
