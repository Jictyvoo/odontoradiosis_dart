enum ICanvasLayers {
  BACKGROUND,
  LANDMARKS,
  ANATOMICAL_TRACING,
}

extension CanvasLayerHelper on ICanvasLayers {
  String get value {
    switch (this) {
      case ICanvasLayers.BACKGROUND:
        return 'image';
      case ICanvasLayers.LANDMARKS:
        return 'landmarks';
      case ICanvasLayers.ANATOMICAL_TRACING:
        return 'bezier';
    }
  }
}
