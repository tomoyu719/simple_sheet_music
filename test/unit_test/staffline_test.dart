import 'package:flutter_test/flutter_test.dart';

import 'package:simple_sheet_music/src/measure/staffline.dart';

void main() {
  test('staffLineYs should generate correct Y positions of staff lines', () {
    // Arrange
    const staffLineCenterY = 100.0;
    final expectedYs = [
      staffLineCenterY - 2 * StaffLineRenderer.staffLineSpaceHeight,
      staffLineCenterY - StaffLineRenderer.staffLineSpaceHeight,
      staffLineCenterY,
      staffLineCenterY + StaffLineRenderer.staffLineSpaceHeight,
      staffLineCenterY + 2 * StaffLineRenderer.staffLineSpaceHeight,
    ];

    // Act
    final generatedYs = staffLineYs(staffLineCenterY);

    // Assert
    expect(generatedYs, expectedYs);
  });
}
