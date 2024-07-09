import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/font_types.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/music_objects/notes/noteflag_type.dart';
import 'package:simple_sheet_music/src/music_objects/notes/notehead_type.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late GlyphMetadata glyphMetadata;
  setUpAll(() async {
    final json = await rootBundle.loadString(FontType.bravuraMetadataPath);
    glyphMetadata = GlyphMetadata(jsonDecode(json) as Map<String, dynamic>);
  });
  test('GlyphMetadata.staffLineThickness should not return null', () async {
    // Act
    final staffLineThickness = glyphMetadata.staffLineThickness;
    // Assert
    expect(staffLineThickness, isNotNull);
  });

  test('GlyphMetadata.legerLineExtension should not return null', () {
    // Act
    final legerLineExtension = glyphMetadata.legerLineExtension;
    // Assert
    expect(legerLineExtension, isNotNull);
  });

  test('GlyphMetadata.legerLineThickness should not return null', () {
    // Act
    final legerLineThickness = glyphMetadata.legerLineThickness;
    // Assert
    expect(legerLineThickness, isNotNull);
  });

  test('GlyphMetadata.stemThickness should not return null', () {
    // Act
    final stemThickness = glyphMetadata.stemThickness;
    // Assert
    expect(stemThickness, isNotNull);
  });

  test('GlyphMetadata.minStemLength should not return null', () {
    // Act
    final minStemLength = glyphMetadata.minStemLength;
    // Assert
    expect(minStemLength, isNotNull);
  });

  test('GlyphMetadata.measureUpperHeight should not return null', () {
    // Act
    final measureUpperHeight = glyphMetadata.measureUpperHeight;
    // Assert
    expect(measureUpperHeight, isNotNull);
  });

  test('GlyphMetadata.measureLowerHeight should not return null', () {
    // Act
    final measureLowerHeight = glyphMetadata.measureLowerHeight;
    // Assert
    expect(measureLowerHeight, isNotNull);
  });

  test('GlyphMetadata.stemRootOffset should not return null', () {
    // Act
    final stemRootOffset = glyphMetadata
        .stemRootOffset(NoteHeadType.black.metadataKey, isStemUp: true);
    // Assert
    expect(stemRootOffset, isNotNull);
  });

  test('GlyphMetadata.stemRootOffset should not return null', () {
    // Act
    final stemRootOffset = glyphMetadata
        .stemRootOffset(NoteHeadType.black.metadataKey, isStemUp: false);
    // Assert
    expect(stemRootOffset, isNotNull);
  });

  test('GlyphMetadata.flagRootOffset should not return null', () {
    // Act
    final flagRootOffset = glyphMetadata
        .flagRootOffset(NoteFlagType.flag128th.upMetadataKey, isStemUp: true);
    // Assert
    expect(flagRootOffset, isNotNull);
  });

  test('GlyphMetadata.flagRootOffset should not return null', () {
    // Act
    final flagRootOffset = glyphMetadata.flagRootOffset(
      NoteFlagType.flag128th.downMetadataKey,
      isStemUp: false,
    );
    // Assert
    expect(flagRootOffset, isNotNull);
  });
}
