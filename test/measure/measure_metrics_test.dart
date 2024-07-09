import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/measure/measure_metrics.dart';

import '../mock/mocks.dart';

void main() {
  test('Objects width should be calculated correctly', () {
    // Arrange
    final musicalSymbols = [
      MockMusicalSymbolMetrics(width: 10),
      MockMusicalSymbolMetrics(width: 20),
      MockMusicalSymbolMetrics(width: 15),
    ];
    final measureMetrics = MeasureMetrics(
      musicalSymbols,
      MockGlyphMetadata(),
      isNewLine: false,
    );
    // Act
    final objectsWidth = measureMetrics.objectsWidth;
    // Assert
    expect(objectsWidth, 45);
  });

  test('Upper height should be calculated correctly', () {
    // Arrange
    final musicalSymbols = [
      MockMusicalSymbolMetrics(upperHeight: 6),
      MockMusicalSymbolMetrics(upperHeight: 10),
      MockMusicalSymbolMetrics(upperHeight: 7),
    ];
    final measureMetrics = MeasureMetrics(
      musicalSymbols,
      MockGlyphMetadata(),
      isNewLine: false,
    );
    // Act
    final upperHeight = measureMetrics.upperHeight;
    // Assert
    expect(upperHeight, 10);
  });
  test(
      'Upper height should be calculated correctly when the measure has a greater upper height',
      () {
    // Arrange
    final musicalSymbols = [
      MockMusicalSymbolMetrics(upperHeight: -5),
      MockMusicalSymbolMetrics(upperHeight: -10),
      MockMusicalSymbolMetrics(upperHeight: -7),
    ];
    const measureUpperHeight = 1.0;
    final metadata = MockGlyphMetadata(measureUpperHeight: measureUpperHeight);
    final measureMetrics = MeasureMetrics(
      musicalSymbols,
      metadata,
      isNewLine: false,
    );
    // Act
    final upperHeight = measureMetrics.upperHeight;
    // Assert
    expect(upperHeight, measureUpperHeight);
  });

  test('Lower height should be calculated correctly', () {
    // Arrange
    final musicalSymbols = [
      MockMusicalSymbolMetrics(lowerHeight: 3),
      MockMusicalSymbolMetrics(lowerHeight: 6),
      MockMusicalSymbolMetrics(lowerHeight: 4),
    ];
    final measureMetrics = MeasureMetrics(
      musicalSymbols,
      MockGlyphMetadata(),
      isNewLine: false,
    );
    // Act
    final lowerHeight = measureMetrics.lowerHeight;
    // Assert
    expect(lowerHeight, 6);
  });

  test('Horizontal margin sum should be calculated correctly', () {
    // Arrange
    final musicalSymbols = [
      MockMusicalSymbolMetrics(
        margin: const EdgeInsets.only(left: 5, right: 3),
      ),
      MockMusicalSymbolMetrics(
        margin: const EdgeInsets.only(left: 2, right: 4),
      ),
      MockMusicalSymbolMetrics(
        margin: const EdgeInsets.only(left: 1, right: 2),
      ),
    ];
    final measureMetrics = MeasureMetrics(
      musicalSymbols,
      MockGlyphMetadata(),
      isNewLine: false,
    );
    // Act
    final horizontalMarginSum = measureMetrics.horizontalMarginSum;
    // Assert
    expect(horizontalMarginSum, 17);
  });
}
