import '../../models/bidimensional_point.dart';

abstract class MouseEventInteraction {
  void onMouseMove(IPointBidimensional event);

  /// Receive a event and manage when to select curve or landmark functions
  void onMouseDown(IPointBidimensional event);

  void onMouseUp();
}
