import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/key_signature/key_signature.dart';
import 'package:simple_sheet_music/src/music_objects/key_signature/keysignature_type.dart';
import 'package:simple_sheet_music/src/musical_context.dart';
import 'mock/mocks.dart';

void main() {
  test('MusicalContext.update should update the clef type correctly', () {
    // Arrange
    const musicalContext =
        MusicalContext(ClefType.treble, KeySignatureType.cMajor);
    const clef = Clef(ClefType.bass);

    // Act
    final updatedContext = musicalContext.update(clef);

    // Assert
    expect(updatedContext.clefType, ClefType.bass);
    expect(updatedContext.keySignatureType, KeySignatureType.cMajor);
  });

  test('MusicalContext.update should update the key signature type correctly',
      () {
    // Arrange
    const musicalContext =
        MusicalContext(ClefType.treble, KeySignatureType.cMajor);
    const keySignature = KeySignature(KeySignatureType.aFlatMinor);

    // Act
    final updatedContext = musicalContext.update(keySignature);

    // Assert
    expect(updatedContext.clefType, ClefType.treble);
    expect(updatedContext.keySignatureType, KeySignatureType.aFlatMinor);
  });

  test(
      'MusicalContext.update should not update the context if the symbol is not a Clef or KeySignature',
      () {
    // Arrange
    const musicalContext =
        MusicalContext(ClefType.treble, KeySignatureType.cMajor);
    final symbol = MockMusicalSymbol();

    // Act
    final updatedContext = musicalContext.update(symbol);

    // Assert
    expect(updatedContext.clefType, ClefType.treble);
    expect(updatedContext.keySignatureType, KeySignatureType.cMajor);
  });

  test('MusicalContext.updateWith should update the clef type correctly', () {
    // Arrange
    const musicalContext =
        MusicalContext(ClefType.treble, KeySignatureType.cMajor);

    // Act
    final updatedContext = musicalContext.updateWith(clefType: ClefType.bass);

    // Assert
    expect(updatedContext.clefType, ClefType.bass);
    expect(updatedContext.keySignatureType, KeySignatureType.cMajor);
  });

  test(
      'MusicalContext.updateWith should update the key signature type correctly',
      () {
    // Arrange
    const musicalContext =
        MusicalContext(ClefType.treble, KeySignatureType.cMajor);

    // Act
    final updatedContext = musicalContext.updateWith(
      keySignatureType: KeySignatureType.aFlatMinor,
    );

    // Assert
    expect(updatedContext.clefType, ClefType.treble);
    expect(updatedContext.keySignatureType, KeySignatureType.aFlatMinor);
  });
}
