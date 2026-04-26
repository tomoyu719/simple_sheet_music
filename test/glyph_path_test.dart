import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/font_types.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';

void main() {
  late GlyphPaths glyphPaths;

  setUpAll(() {
    glyphPaths = GlyphPaths(FontType.bravura.glyphs);
  });

  test('parsePath should not return null', () {
    // Act
    final path = glyphPaths.parsePath(ClefType.treble.pathKey);
    // Assert
    expect(path, isNotNull);
  });
}
