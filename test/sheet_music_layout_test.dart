import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

import 'mock/mock_sheet_music_metrics.dart';

void main() {
  test(
      'SheetMusicLayout.canvasScale should be the minimum scale factor to fit the sheet music in the widget',
      () {
    // Arrange
    const maximumStaffWidth = 100.0;
    final metrics = MockSheetMusicMetrics(
      maximumStaffWidth: maximumStaffWidth,
      staffsHeightSum: 1,
    );
    const widgetWidth = 100.0;
    final layout = SheetMusicLayout(
      metrics,
      Colors.black,
      widgetHeight: 100,
      widgetWidth: widgetWidth,
    );

    // Act
    final canvasScale = layout.canvasScale;

    // Assert
    expect(canvasScale, maximumStaffWidth / widgetWidth);
  });
}
