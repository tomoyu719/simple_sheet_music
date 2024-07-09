import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/font_types.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:xml/xml.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late GlyphPaths glyphPaths;
  setUpAll(() async {
    final xml = await rootBundle.loadString(FontType.bravuraSvgPath);
    final document = XmlDocument.parse(xml);
    final allGlyphs = document.findAllElements('glyph').toSet();
    glyphPaths = GlyphPaths(allGlyphs);
  });
  test('parsePath should not return null', () {
    // Act
    final path = glyphPaths.parsePath(ClefType.treble.pathKey);
    // Assert
    expect(path, isNotNull);
  });
}
