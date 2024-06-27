import 'package:flutter/rendering.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_y0.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

abstract class MusicalSymbol {

  const MusicalSymbol(this.color, this.specifiedMargin);
  final EdgeInsets? specifiedMargin;
  final Color color;

  MusicalSymbolOnY0 renderer(SheetMusicLayout layout);
  // MusicalObject copyWith({Color? newColor, EdgeInsets? newSpecifiedMargin});
}
