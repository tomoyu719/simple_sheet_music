import 'package:flutter/material.dart';

/// A mixin that provides a method for painting text on a canvas.
mixin TextPaint {
  static const topToBaselineHeight = 8.0;
  static const fontSize = 4.0;

  /// Paints the specified glyph on the canvas at the given offset.
  ///
  /// The `canvas` parameter represents the canvas on which the text will be painted.
  /// The `size` parameter represents the size of the canvas.
  /// The `glyph` parameter represents the text to be painted.
  /// The `offset` parameter represents the position where the text will be painted.
  /// The `color` parameter represents the color of the text.
  /// The `fontFamily` parameter represents the font family of the text.
  void textPaint(
    Canvas canvas,
    Size size,
    String glyph,
    Offset offset,
    Color color,
    String? fontFamily,
  ) {
    TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
          style: TextStyle(
              color: color, fontSize: fontSize, fontFamily: fontFamily),
          text: glyph),
    )
      ..layout(
        minWidth: 0,
        maxWidth: size.width,
      )
      ..paint(canvas, offset.translate(0, -topToBaselineHeight));
  }
}
