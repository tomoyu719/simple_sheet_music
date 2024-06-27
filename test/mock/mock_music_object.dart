import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';

class MockMusicalSymbol extends Fake implements MusicalSymbol {
  // @override
  // MusicalSymbolRenderer renderer(SheetMusicLayout layout) {
  //   return MockMusicalSymbolRenderer();
  // }
}

class MockMusicalSymbolRenderer extends Fake implements MusicalSymbolRenderer {
  MockMusicalSymbolRenderer();

  double get width => 0;
  double get upperHeight => 0;
  double get lowerHeight => 0;

  late final Offset renderOffset;
}
