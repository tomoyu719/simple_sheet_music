import 'dart:ui';

/// The abstract class for rendering barlines.
abstract class BarlineRenderer {
  /// The width of the barline.
  double get width;

  /// Renders the barline on the canvas.
  ///
  /// The [canvas] is the canvas on which the barline will be rendered.
  /// The [staffLineCenterY] is the y-coordinate of the center of the staff line.
  void render(Canvas canvas);
}
