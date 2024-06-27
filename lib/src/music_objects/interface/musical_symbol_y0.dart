import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';

import 'musical_symbol.dart';

//TODO rename
abstract class MusicalSymbolOnY0 {

  MusicalSymbolOnY0(this.musicalSymbol);
  final MusicalSymbol musicalSymbol;

  double get width;

  double get upperHeight;

  double get lowerHeight;

  MusicalSymbolRenderer renderer(
      {required double staffLineCenterY, required double symbolX,});
}
