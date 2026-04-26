import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/staff/staff_renderer.dart';

import '../mock/mocks.dart';

void main() {
  test('StaffRenderer should calculate the correct upper height', () {
    // Arrange
    final measure1 = MockMeasureRenderer(
      upperHeight: 10,
      lowerHeight: 5,
      objectsWidth: 20,
      horizontalMarginSum: 5,
    );
    final measure2 = MockMeasureRenderer(
      upperHeight: 8,
      lowerHeight: 6,
      objectsWidth: 15,
      horizontalMarginSum: 3,
    );
    final staffRenderer = StaffRenderer([measure1, measure2]);

    // Act
    final upperHeight = staffRenderer.upperHeight;

    // Assert
    expect(upperHeight, 10);
  });

  test('StaffRenderer should calculate the correct lower height', () {
    // Arrange
    final measure1 = MockMeasureRenderer(
      upperHeight: 10,
      lowerHeight: 5,
      objectsWidth: 20,
      horizontalMarginSum: 5,
    );
    final measure2 = MockMeasureRenderer(
      upperHeight: 8,
      lowerHeight: 6,
      objectsWidth: 15,
      horizontalMarginSum: 3,
    );
    final staffRenderer = StaffRenderer([measure1, measure2]);

    // Act
    final lowerHeight = staffRenderer.lowerHeight;

    // Assert
    expect(lowerHeight, 6);
  });

  test('StaffRenderer should calculate the correct width', () {
    // Arrange
    final measure1 = MockMeasureRenderer(
      upperHeight: 10,
      lowerHeight: 5,
      objectsWidth: 20,
      horizontalMarginSum: 5,
    );
    final measure2 = MockMeasureRenderer(
      upperHeight: 8,
      lowerHeight: 6,
      objectsWidth: 15,
      horizontalMarginSum: 3,
    );
    final staffRenderer = StaffRenderer([measure1, measure2]);

    // Act
    final width = staffRenderer.width;

    // Assert
    expect(width, 43);
  });

  test('StaffRenderer should calculate the correct height', () {
    // Arrange
    final measure1 = MockMeasureRenderer(
      upperHeight: 10,
      lowerHeight: 5,
      objectsWidth: 20,
      horizontalMarginSum: 5,
    );
    final measure2 = MockMeasureRenderer(
      upperHeight: 8,
      lowerHeight: 6,
      objectsWidth: 15,
      horizontalMarginSum: 3,
    );
    final staffRenderer = StaffRenderer([measure1, measure2]);

    // Act
    final height = staffRenderer.height;

    // Assert
    expect(height, 16);
  });
}
