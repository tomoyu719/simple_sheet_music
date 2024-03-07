import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/extension/rect_extension.dart';

void main() {
  test('AddMargin should add margin to the rectangle correctly', () {
    // Arrange
    const rect = Rect.fromLTRB(0, 0, 100, 100);
    const margin = EdgeInsets.all(10);
    const expectedRect = Rect.fromLTRB(-10, -10, 110, 110);

    // Act
    final result = rect.addMargin(margin);

    // Assert
    expect(result, expectedRect);
  });
}
