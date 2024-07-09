import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/key_signature/keysignature_type.dart';

void main() {
  test(
      'keySignaturePositions(clefType) correctly returns the key positions for D major when a treble clef (clefType) is used',
      () {
    // Arrange
    const keySignatureType = KeySignatureType.dMajor;
    const clefType = ClefType.treble;
    // Act
    final keySignaturePositions =
        keySignatureType.keySignaturePositions(clefType);
    // Assert
    expect(keySignaturePositions.length, 2);
    expect(keySignaturePositions, [4, 1]);
  });
  test(
      'keySignaturePositions(clefType) correctly returns the key positions for B flat minor when a treble clef (clefType) is used',
      () {
    // Arrange
    const keySignatureType = KeySignatureType.bFlatMinor;
    const clefType = ClefType.bass;
    // Act
    final keySignaturePositions =
        keySignatureType.keySignaturePositions(clefType);
    // Assert
    expect(keySignaturePositions.length, 5);
    expect(keySignaturePositions, [-2, 1, -3, 0, -4]);
  });
  test(
      'keySignaturePositions(clefType) correctly returns blank key positions when a C major key signature is used',
      () {
    // Arrange
    const keySignatureType = KeySignatureType.cMajor;
    const clefType = ClefType.bass;
    // Act
    final keySignaturePositions =
        keySignatureType.keySignaturePositions(clefType);
    // Assert
    expect(keySignaturePositions.length, 0);
  });
  test(
      'hasParts returns true for key signatures other than C major and A minor',
      () {
    // Arrange
    final keySignatureTypes = KeySignatureType.values.where(
      (keySignatureType) =>
          keySignatureType != KeySignatureType.cMajor &&
          keySignatureType != KeySignatureType.aMinor,
    );

    for (final keySignatureType in keySignatureTypes) {
      // Act
      final hasParts = keySignatureType.hasParts;
      // Assert
      expect(hasParts, true);
    }
  });

  test('hasParts returns false for C major key signature', () {
    // Arrange
    const keySignatureType = KeySignatureType.cMajor;
    // Act
    final hasParts = keySignatureType.hasParts;
    // Assert
    expect(hasParts, false);
  });

  test('hasParts returns false for A minor key signature', () {
    // Arrange
    const keySignatureType = KeySignatureType.aMinor;
    // Act
    final hasParts = keySignatureType.hasParts;
    // Assert
    expect(hasParts, false);
  });
}
