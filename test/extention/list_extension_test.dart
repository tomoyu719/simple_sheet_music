import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/extension/list_extension.dart';

void main() {
  group('IterableExtension', () {
    test('sum should return the correct sum of elements', () {
      // Arrange
      final list = [1.0, 2.0, 3.0, 4.0, 5.0];

      // Act
      final result = list.sum;

      // Assert
      expect(result, 15.0);
    });
    test('sum should return 0 when the list is empty', () {
      // Arrange
      final list = <double>[];

      // Act
      final result = list.sum;

      // Assert
      expect(result, 0.0);
    });

    test('max should return the maximum element', () {
      // Arrange
      final list = [1.0, 2.0, 3.0, 4.0, 5.0];

      // Act
      final result = list.max;

      // Assert
      expect(result, 5.0);
    });

    test('max should throw an exception when the list is empty', () {
      // Arrange
      final list = <double>[];

      // Act
      double result() => list.max;

      // Assert
      expect(result, throwsStateError);
    });

    test('min should return the minimum element', () {
      // Arrange
      final list = [1.0, 2.0, 3.0, 4.0, 5.0];

      // Act
      final result = list.min;

      // Assert
      expect(result, 1.0);
    });

    test('min should throw an exception when the list is empty', () {
      // Arrange
      final list = <double>[];

      // Act
      double result() => list.min;

      // Assert
      expect(result, throwsStateError);
    });
  });
}
