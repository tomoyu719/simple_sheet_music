import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/key_signature/keysignature_type.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';
import 'package:flutter/material.dart';

import 'mock/mocks.dart';

void main() {
  test('SheetMusicLayout should calculate staffRenderers correctly', () {
    // Arrange
    final measures = [
      MockMeasure(),
      MockMeasure(),
      MockMeasure(),
    ];
    final sheetMusicLayout = SheetMusicLayout(
      musicalSymbols: measures,
      initialClefType: ClefType.treble,
      initialKeySignatureType: KeySignatureType.cMajor,
      metadata: MockGlyphMetadata(),
      paths: MockGlyphPath(),
      lineColor: Colors.black,
      widgetWidth: 400,
      widgetHeight: 400,
    );

    // Act
    final staffRenderers = sheetMusicLayout.staffRenderers;

    // Assert
    expect(staffRenderers.length, equals(1));
    expect(staffRenderers.first.measureRenderers.length, equals(3));
  });
  test(
      'SheetMusicLayout should calculate staffRenderers correctly even if there is a new line measure',
      () {
    // Arrange
    final measures = [
      MockMeasure(),
      MockMeasure(),
      MockMeasure(isNewLine: true),
    ];
    final sheetMusicLayout = SheetMusicLayout(
      musicalSymbols: measures,
      initialClefType: ClefType.treble,
      initialKeySignatureType: KeySignatureType.cMajor,
      metadata: MockGlyphMetadata(),
      paths: MockGlyphPath(),
      lineColor: Colors.black,
      widgetWidth: 400,
      widgetHeight: 400,
    );

    // Act
    final staffRenderers = sheetMusicLayout.staffRenderers;

    // Assert
    expect(staffRenderers.length, equals(2));
    expect(staffRenderers[0].measureRenderers.length, equals(2));
    expect(staffRenderers[1].measureRenderers.length, equals(1));
  });
  test(
      'SheetMusicLayout should calculate staffRenderers correctly even if first measure is a new line measure',
      () {
    // Arrange
    final measures = [
      MockMeasure(isNewLine: true),
      MockMeasure(),
      MockMeasure(),
    ];
    final sheetMusicLayout = SheetMusicLayout(
      musicalSymbols: measures,
      initialClefType: ClefType.treble,
      initialKeySignatureType: KeySignatureType.cMajor,
      metadata: MockGlyphMetadata(),
      paths: MockGlyphPath(),
      lineColor: Colors.black,
      widgetWidth: 400,
      widgetHeight: 400,
    );

    // Act
    final staffRenderers = sheetMusicLayout.staffRenderers;

    // Assert
    expect(staffRenderers.length, equals(1));
    expect(staffRenderers.first.measureRenderers.length, equals(3));
  });
}
