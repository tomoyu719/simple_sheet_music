import 'package:flutter/rendering.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_y0.dart';

abstract class MusicalSymbolRenderer {
  MusicalSymbolRenderer();
  MusicalSymbolOnY0 get musicalSymbol;

  Rect get renderArea;

  bool isHit(Offset position);

  // final Offset renderOffset;
  void render(Canvas canvas, Size size);
}
