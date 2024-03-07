import 'dart:ui';

import '../barline.dart';
import '../barline_renderer.dart';
import 'barline_thick_renderer.dart';
import 'barline_thin_renderer.dart';

/// A renderer for the final barline in a measure.
/// This class implements the [BarlineRenderer] interface.
/// It renders a thin barline and a thick barline on the canvas.
class BarlineFinalRenderer implements BarlineRenderer {
  static const separation = 0.4;
  static const barline = Barline.barlineFinal;

  final Color color;
  final double barlineRightX;
  final double staffLineCenterY;

  /// Constructs a [BarlineFinalRenderer] with the given parameters.
  const BarlineFinalRenderer(
      {required this.color,
      required this.barlineRightX,
      required this.staffLineCenterY});

  @override
  double get width => barline.width;

  /// The x-coordinate of the right end of the thick barline.
  double get _barlineThickRightX => barlineRightX;

  /// The x-coordinate of the right end of the thin barline.
  double get _barlineThinRightX =>
      barlineRightX - _barlineThickWidth - separation;

  /// The width of the thick barline.
  double get _barlineThickWidth => _barlineThickRenderer.width;

  /// The renderer for the thin barline.
  BarlineThinRenderer get _barlineThinRenderer => BarlineThinRenderer(
      color: color,
      barlineRightX: _barlineThinRightX,
      staffLineCenterY: staffLineCenterY);

  /// The renderer for the thick barline.
  BarlineThickRenderer get _barlineThickRenderer => BarlineThickRenderer(
      color: color,
      barlineRightX: _barlineThickRightX,
      staffLineCenterY: staffLineCenterY);

  @override
  void render(Canvas canvas) {
    _barlineThinRenderer.render(canvas);
    _barlineThickRenderer.render(canvas);
  }
}
