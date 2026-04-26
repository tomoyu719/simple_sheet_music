import 'package:flutter/rendering.dart';

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

  /// Sets the position information for rendering.
  ///
  /// This must be called before [render] or [isHit].
  void setPosition({
    required double canvasScale,
    required double staffLineCenterY,
    required double symbolX,
  });

  /// Checks if the symbol is hit at the given position.
  ///
  /// [setPosition] must be called before this method.
  bool isHit(Offset position);

  /// Renders the symbol on the given canvas.
  ///
  /// [setPosition] must be called before this method.
  void render(Canvas canvas);
}
