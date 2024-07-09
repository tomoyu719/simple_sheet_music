import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/staff/staff_metrics.dart';

import '../mock/mocks.dart';

void main() {
  test('StaffMetrics should calculate the correct upper height', () {
    // Arrange
    final measure1 = MockMeasureMetrics(
      upperHeight: 10,
      lowerHeight: 5,
      objectsWidth: 20,
      horizontalMarginSum: 5,
    );
    final measure2 = MockMeasureMetrics(
      upperHeight: 8,
      lowerHeight: 6,
      objectsWidth: 15,
      horizontalMarginSum: 3,
    );
    final staffMetrics = StaffMetrics([measure1, measure2]);

    // Act
    final upperHeight = staffMetrics.upperHeight;

    // Assert
    expect(upperHeight, 10);
  });

  test('StaffMetrics should calculate the correct lower height', () {
    // Arrange
    final measure1 = MockMeasureMetrics(
      upperHeight: 10,
      lowerHeight: 5,
      objectsWidth: 20,
      horizontalMarginSum: 5,
    );
    final measure2 = MockMeasureMetrics(
      upperHeight: 8,
      lowerHeight: 6,
      objectsWidth: 15,
      horizontalMarginSum: 3,
    );
    final staffMetrics = StaffMetrics([measure1, measure2]);

    // Act
    final lowerHeight = staffMetrics.lowerHeight;

    // Assert
    expect(lowerHeight, 6);
  });

  test('StaffMetrics should calculate the correct width', () {
    // Arrange
    final measure1 = MockMeasureMetrics(
      upperHeight: 10,
      lowerHeight: 5,
      objectsWidth: 20,
      horizontalMarginSum: 5,
    );
    final measure2 = MockMeasureMetrics(
      upperHeight: 8,
      lowerHeight: 6,
      objectsWidth: 15,
      horizontalMarginSum: 3,
    );
    final staffMetrics = StaffMetrics([measure1, measure2]);

    // Act
    final width = staffMetrics.width;

    // Assert
    expect(width, 43);
  });

  test('StaffMetrics should calculate the correct height', () {
    // Arrange
    final measure1 = MockMeasureMetrics(
      upperHeight: 10,
      lowerHeight: 5,
      objectsWidth: 20,
      horizontalMarginSum: 5,
    );
    final measure2 = MockMeasureMetrics(
      upperHeight: 8,
      lowerHeight: 6,
      objectsWidth: 15,
      horizontalMarginSum: 3,
    );
    final staffMetrics = StaffMetrics([measure1, measure2]);

    // Act
    final height = staffMetrics.height;

    // Assert
    expect(height, 16);
  });
}
