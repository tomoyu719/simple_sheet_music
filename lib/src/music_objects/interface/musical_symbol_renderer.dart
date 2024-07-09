import 'package:flutter/rendering.dart';

/// An abstract class representing a renderer for a musical symbol.
abstract class MusicalSymbolRenderer {
  MusicalSymbolRenderer();

  /// Checks if the symbol is hit at the given position.
  bool isHit(Offset position);

  /// Renders the symbol on the given canvas.
  void render(Canvas canvas);
}
