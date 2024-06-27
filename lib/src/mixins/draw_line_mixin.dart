import 'package:flutter/material.dart';

/// A mixin that provides functionality for drawing lines on a canvas.
mixin LineDrawer {
  static const offsetHeightTopToFontBaseLine = 8.0;
  static const offsetHeight = Offset(0, 8);

  /// Returns a Paint object with the specified color and thickness.
  Paint _getPaint(Color c, double thickness) {
    return Paint()
      ..color = c
      ..strokeWidth = thickness;
  }

  /// Draws a line on the canvas using the specified starting and ending points,
  /// thickness, and color.
  void drawLine(
      Canvas canvas, Offset p1, Offset p2, double thickness, Color color,) {
    canvas.drawLine(p1, p2, _getPaint(color, thickness));
  }
}
