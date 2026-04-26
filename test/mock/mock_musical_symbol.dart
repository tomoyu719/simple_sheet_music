import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol.dart';
import 'package:simple_sheet_music/src/musical_context.dart';

import 'mock_musical_symbol_renderer.dart';

class MockMusicalSymbol extends Fake implements MusicalSymbol {
  @override
  MockMusicalSymbolRenderer setContext(
    MusicalContext context,
    GlyphMetadata metadata,
    GlyphPaths paths,
  ) =>
      MockMusicalSymbolRenderer(context: context);
}
