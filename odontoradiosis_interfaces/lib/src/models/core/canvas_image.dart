class ICanvasImage {
  String imageData;
  bool isLoaded;
  bool isFromStorage;

  ICanvasImage(this.imageData)
      : isLoaded = false,
        isFromStorage = false;
}
