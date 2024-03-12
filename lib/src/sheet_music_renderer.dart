import 'package:flutter/material.dart';

import 'mixins/draw_line_mixin.dart';
import 'mixins/text_paint_mixin.dart';
import 'staff/staff_on_canvas.dart';

/// A custom painter that renders sheet music on a canvas.
///
/// This class extends [CustomPainter] and implements [LineDrawer] and [TextPaint].
/// It takes a list of [StaffOnCanvas] objects, a canvas scale, and a font family as parameters.
/// The [StaffOnCanvas] objects represent staves and their associated measures and music objects drawn on the canvas.
/// The [canvasScale] parameter determines the scale at which the sheet music is rendered on the canvas.
/// The [fontFamily] parameter specifies the font family to be used for rendering text.
class SheetMusicRenderer extends CustomPainter with LineDrawer, TextPaint {
  final List<StaffOnCanvas> staffsOnCanvas;

  final double canvasScale;
  final String fontFamily;

  const SheetMusicRenderer(
      this.staffsOnCanvas, this.canvasScale, this.fontFamily);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(canvasScale);
    for (final staff in staffsOnCanvas) {
      staff.render(canvas, size, fontFamily);
    }
  }

  @override
  bool shouldRepaint(SheetMusicRenderer oldDelegate) {
    return true;
  }
}
