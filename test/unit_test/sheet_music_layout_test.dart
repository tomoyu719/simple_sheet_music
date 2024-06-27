import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

import '../mock/mock_music_object.dart';

void main() {
  group('SheetMusicLayout', () {
    test('should create staffs correctly', () {
      // Arrange
      final measures = [
        Measure([MockMusicalSymbol()], isLineBreak: true),
        Measure([MockMusicalSymbol()]),
        Measure([MockMusicalSymbol()], isLineBreak: true),
        Measure([MockMusicalSymbol()]),
      ];
      const maximumWidth = 200.0;
      const maximumHeight = 300.0;
      final layout = SheetMusicLayout(
        measures,
        MockGlyphMetadata(),
        MockGlyphPath(),
        Colors.black,
        maximumWidth: 1,
        maximumHeight: 1,
      );

      // Act
      final staffs = layout.staffs;

      // Assert
      expect(staffs.length, 3);
      expect(staffs[0].measures.length, 1);
      expect(staffs[1].measures.length, 2);
      expect(staffs[2].measures.length, 1);
    });
  });
}

class MockGlyphMetadata extends Fake implements GlyphMetadata {}

class MockGlyphPath extends Fake implements GlyphPaths {}
