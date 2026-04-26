import 'package:flutter/rendering.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

/// An abstract class representing a renderer for a musical symbol.
abstract class MusicalSymbolRenderer {
  /// The width of the musical symbol.
  double get width;

  /// The height above centre line of the stave of the musical symbol.
  double get upperHeight;

  /// The height below centre line of the stave of the musical symbol.
  double get lowerHeight;

  /// The margin around the musical symbol. Vertical margin is not used.
  EdgeInsets get margin;

  /// Checks if the symbol is hit at the given position.
  bool isHit(
    Offset position, {
    required SheetMusicLayout layout,
    required double staffLineCenterY,
    required double symbolX,
  });

  /// Renders the symbol on the given canvas.
  void render(
    Canvas canvas, {
    required SheetMusicLayout layout,
    required double staffLineCenterY,
    required double symbolX,
  });
}
