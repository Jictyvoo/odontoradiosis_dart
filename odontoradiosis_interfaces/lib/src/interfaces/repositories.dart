import 'controllers/curve_manipulation.dart';
import 'controllers/landmark_manipulation.dart';

enum EStorageKey { BEZIER_CURVES, LANDMARKS, IMAGE_DATA }

extension EStorageKeyHelper on EStorageKey {
  String get name {
    switch (this) {
      case EStorageKey.BEZIER_CURVES:
        return 'bezier_curves';
      case EStorageKey.LANDMARKS:
        return 'saved_points';
      case EStorageKey.IMAGE_DATA:
        return 'imageData';
    }
  }
}

abstract class ILocalRepository<T> {
  T? get(String key);

  void set(String key, T value);

  void remove(String key);
}

abstract class TracingRepository implements ILocalRepository<ITracingCurves> {}

abstract class LandmarkRepository implements ILocalRepository<ILandmarkArray> {}

abstract class ImageRepository implements ILocalRepository<String> {}
