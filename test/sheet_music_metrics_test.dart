import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/key_signature/keysignature_type.dart';
import 'package:simple_sheet_music/src/sheet_music_metrics.dart';

import 'mock/mocks.dart';

void main() {
  test('SheetMusicMetrics should calculate staffsMetricses correctly', () {
    // Arrange
    final measures = [
      MockMeasure(),
      MockMeasure(),
      MockMeasure(),
    ];
    final sheetMusicMetrics = SheetMusicMetrics(
      measures,
      ClefType.treble,
      KeySignatureType.cMajor,
      MockGlyphMetadata(),
      MockGlyphPath(),
    );

    // Act
    final staffsMetricses = sheetMusicMetrics.staffsMetricses;

    // Assert
    expect(staffsMetricses.length, equals(1));
    expect(staffsMetricses.first.measuresMetricses.length, equals(3));
  });
  test(
      'SheetMusicMetrics should calculate staffsMetricses correctly even if there is a new line measure',
      () {
    // Arrange
    final measures = [
      MockMeasure(),
      MockMeasure(),
      MockMeasure(isNewLine: true),
    ];
    final sheetMusicMetrics = SheetMusicMetrics(
      measures,
      ClefType.treble,
      KeySignatureType.cMajor,
      MockGlyphMetadata(),
      MockGlyphPath(),
    );

    // Act
    final staffsMetricses = sheetMusicMetrics.staffsMetricses;

    // Assert
    expect(staffsMetricses.length, equals(2));
    expect(staffsMetricses[0].measuresMetricses.length, equals(2));
    expect(staffsMetricses[1].measuresMetricses.length, equals(1));
  });
  test(
      'SheetMusicMetrics should calculate staffsMetricses correctly even if first measure is a new line measure',
      () {
    // Arrange
    final measures = [
      MockMeasure(isNewLine: true),
      MockMeasure(),
      MockMeasure(),
    ];
    final sheetMusicMetrics = SheetMusicMetrics(
      measures,
      ClefType.treble,
      KeySignatureType.cMajor,
      MockGlyphMetadata(),
      MockGlyphPath(),
    );

    // Act
    final staffsMetricses = sheetMusicMetrics.staffsMetricses;

    // Assert
    expect(staffsMetricses.length, equals(1));
    expect(staffsMetricses.first.measuresMetricses.length, equals(3));
  });

  // TODO implement
  // test('SheetMusicMetrics should calculate maximumStaffWidth correctly', () {
  //   // Act
  //   final maximumStaffWidth = sheetMusicMetrics.maximumStaffWidth;

  //   // Assert
  //   expect(maximumStaffWidth, equals(150));
  // });

  // TODO implement
  // test(
  //     'SheetMusicMetrics should calculate maximumStaffHorizontalMarginSum correctly',
  //     () {
  //   // Act
  //   final maximumStaffHorizontalMarginSum =
  //       sheetMusicMetrics.maximumStaffHorizontalMarginSum;

  //   // Assert
  //   expect(maximumStaffHorizontalMarginSum, equals(15));
  // });

  // TODO implement
  // test('SheetMusicMetrics should calculate staffUpperHeight correctly', () {
  //   // Act
  //   final staffUpperHeight = sheetMusicMetrics.staffUpperHeight;

  //   // Assert
  //   expect(staffUpperHeight, equals(60));
  // });

  // TODO implement
  // test('SheetMusicMetrics should calculate staffLowerHeight correctly', () {
  //   // Act
  //   final staffLowerHeight = sheetMusicMetrics.staffLowerHeight;

  //   // Assert
  //   expect(staffLowerHeight, equals(40));
  // });

  // TODO implement
  // test('SheetMusicMetrics should calculate staffsHeightSum correctly', () {
  //   // Act
  //   final staffsHeightSum = sheetMusicMetrics.staffsHeightSum;

  //   // Assert
  //   expect(staffsHeightSum, equals(330));
  // });
}
