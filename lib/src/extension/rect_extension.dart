import 'package:flutter/material.dart';

/// Extension method on [Rect] to add margin to the rectangle.
extension AddMargin on Rect {
  /// Adds the specified [margin] to the rectangle and returns the resulting rectangle.
  Rect addMargin(EdgeInsets margin) {
    final marginedLeft = left - margin.left;
    final marginedTop = top - margin.top;
    final marginedRight = right + margin.right;
    final marginedBottom = bottom + margin.bottom;
    return Rect.fromLTRB(
        marginedLeft, marginedTop, marginedRight, marginedBottom);
  }
}
