import 'package:simple_sheet_music/src/extension/list_extension.dart';
import 'package:simple_sheet_music/src/measure/measure_renderer.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_y0.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

import '../music_objects/interface/musical_symbol.dart';

class MeasureOnY0 {
  MeasureOnY0(List<MusicalSymbol> musicalSymbols, this.layout)
      : musicalSymbolsOnY0 =
            musicalSymbols.map((symbol) => symbol.renderer(layout)).toList();
  final List<MusicalSymbolOnY0> musicalSymbolsOnY0;

  final SheetMusicLayout layout;

  double get width => musicalSymbolsOnY0.map((symbol) => symbol.width).sum;

  double get upperHeight =>
      musicalSymbolsOnY0.map((symbol) => symbol.upperHeight).max;

  double get lowerHeight =>
      musicalSymbolsOnY0.map((symbol) => symbol.lowerHeight).max;

  MeasureRenderer renderer(
          {required double measureOriginX, required double staffLineCenterY,}) =>
      MeasureRenderer(this, musicalSymbolsOnY0,
          measureOriginX: measureOriginX, staffLineCenterY: staffLineCenterY,);
}
