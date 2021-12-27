abstract class ILayeredCanvas {
  /// Change the cursor of the canvas stacks
  set canvasCursor(String newCursor);

  /// Sets the rendering layer order
  set layerOrder(Map<String, int> order);
}
