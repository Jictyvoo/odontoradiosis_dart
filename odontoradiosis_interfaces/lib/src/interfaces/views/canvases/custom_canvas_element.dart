import 'canvas_render_context.dart';
import 'custom_client_rect.dart';

abstract class HTMLCanvasElement {
  ClientRect getBoundingClientRect();

  CanvasRenderingContext2D getContext([String name = '2d']);
}
