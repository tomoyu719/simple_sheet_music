import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/key_signature/key_signature_helper.dart';
import 'package:simple_sheet_music/src/music_objects/key_signature/key_signature.dart';

void main() {
  test('keySignatureParts should generate key signature parts num correctly',
      () {
    // Arrange
    const clefType = ClefType.treble;
    const keySignatureType = KeySignatureType.aFlatMajor;
    final keySignaturePartPositions =
        keySignatureType.keySignaturePositions(clefType);
    const isSharp = true;

    // Act
    final result =
        keySignatureParts(keySignaturePartPositions, isSharp: isSharp);

    // Assert
    expect(result.length, 4);
  });

  test('keySignatureParts should generate key signature parts num correctly',
      () {
    // Arrange
    const clefType = ClefType.treble;
    const keySignatureType = KeySignatureType.cMajor;
    final keySignaturePartPositions =
        keySignatureType.keySignaturePositions(clefType);
    const isSharp = false;

    // Act
    final result =
        keySignatureParts(keySignaturePartPositions, isSharp: isSharp);

    // Assert
    expect(result.length, 0);
  });
}
