import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/measure/measure_renderer.dart';

import '../mock/mocks.dart';

void main() {
  test('Objects width should be calculated correctly', () {
    // Arrange
    final musicalSymbols = [
      MockMusicalSymbolRenderer(width: 10),
      MockMusicalSymbolRenderer(width: 20),
      MockMusicalSymbolRenderer(width: 15),
    ];
    final measureRenderer = MeasureRenderer(
      musicalSymbols,
      MockGlyphMetadata(),
      isNewLine: false,
    );
    // Act
    final objectsWidth = measureRenderer.objectsWidth;
    // Assert
    expect(objectsWidth, 45);
  });

  test('Upper height should be calculated correctly', () {
    // Arrange
    final musicalSymbols = [
      MockMusicalSymbolRenderer(upperHeight: 6),
      MockMusicalSymbolRenderer(upperHeight: 10),
      MockMusicalSymbolRenderer(upperHeight: 7),
    ];
    final measureRenderer = MeasureRenderer(
      musicalSymbols,
      MockGlyphMetadata(),
      isNewLine: false,
    );
    // Act
    final upperHeight = measureRenderer.upperHeight;
    // Assert
    expect(upperHeight, 10);
  });
  test(
      'Upper height should be calculated correctly when the measure has a greater upper height',
      () {
    // Arrange
    final musicalSymbols = [
      MockMusicalSymbolRenderer(upperHeight: -5),
      MockMusicalSymbolRenderer(upperHeight: -10),
      MockMusicalSymbolRenderer(upperHeight: -7),
    ];
    const measureUpperHeight = 1.0;
    final metadata = MockGlyphMetadata(measureUpperHeight: measureUpperHeight);
    final measureRenderer = MeasureRenderer(
      musicalSymbols,
      metadata,
      isNewLine: false,
    );
    // Act
    final upperHeight = measureRenderer.upperHeight;
    // Assert
    expect(upperHeight, measureUpperHeight);
  });

  test('Lower height should be calculated correctly', () {
    // Arrange
    final musicalSymbols = [
      MockMusicalSymbolRenderer(lowerHeight: 3),
      MockMusicalSymbolRenderer(lowerHeight: 6),
      MockMusicalSymbolRenderer(lowerHeight: 4),
    ];
    final measureRenderer = MeasureRenderer(
      musicalSymbols,
      MockGlyphMetadata(),
      isNewLine: false,
    );
    // Act
    final lowerHeight = measureRenderer.lowerHeight;
    // Assert
    expect(lowerHeight, 6);
  });

  test('Horizontal margin sum should be calculated correctly', () {
    // Arrange
    final musicalSymbols = [
      MockMusicalSymbolRenderer(
        margin: const EdgeInsets.only(left: 5, right: 3),
      ),
      MockMusicalSymbolRenderer(
        margin: const EdgeInsets.only(left: 2, right: 4),
      ),
      MockMusicalSymbolRenderer(
        margin: const EdgeInsets.only(left: 1, right: 2),
      ),
    ];
    final measureRenderer = MeasureRenderer(
      musicalSymbols,
      MockGlyphMetadata(),
      isNewLine: false,
    );
    // Act
    final horizontalMarginSum = measureRenderer.horizontalMarginSum;
    // Assert
    expect(horizontalMarginSum, 17);
  });
}
