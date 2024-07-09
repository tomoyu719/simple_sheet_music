import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/music_objects/notes/note_pitch.dart';

void main() {
  test('Pitch.up should return the next pitch', () {
    // Arrange
    const pitch = Pitch.c4;
    // Act
    final nextPitch = pitch.up;
    // Assert
    expect(nextPitch, Pitch.d4);
  });

  test('Pitch.down should return the previous pitch', () {
    // Arrange
    const pitch = Pitch.c4;
    // Act
    final previousPitch = pitch.down;
    // Assert
    expect(previousPitch, Pitch.b3);
  });

  test('Pitch.upN should return the pitch n steps above', () {
    // Arrange
    const pitch = Pitch.c4;
    const n = 3;
    // Act
    final upNPitch = pitch.upN(n);
    // Assert
    expect(upNPitch, Pitch.f4);
  });

  test('Pitch.downN should return the pitch n steps below', () {
    // Arrange
    const pitch = Pitch.c4;
    const n = 2;
    // Act
    final downNPitch = pitch.downN(n);
    // Assert
    expect(downNPitch, Pitch.a3);
  });

  test('Pitch.up should return the same pitch if it is the highest pitch', () {
    // Arrange
    final pitch = Pitch.values.last;
    // Act
    final upNPitch = pitch.up;
    // Assert
    expect(upNPitch, pitch);
  });

  test('Pitch.down should return the same pitch if it is the lowest pitch', () {
    // Arrange
    final pitch = Pitch.values.first;
    // Act
    final downPitch = pitch.down;
    // Assert
    expect(downPitch, pitch);
  });

  test('Pitch.upOctave should return a pitch an octave upper', () {
    // Arrange
    const pitch = Pitch.a4;
    // Act
    final upOctavePitch = pitch.upOctave;
    // Assert
    expect(upOctavePitch, Pitch.a5);
  });

  test('Pitch.downOctave should return a pitch an octave lower', () {
    // Arrange
    const pitch = Pitch.a4;
    // Act
    final downOctavePitch = pitch.downOctave;
    // Assert
    expect(downOctavePitch, Pitch.a3);
  });

  /// operator >= test
  test(
      'Pitch operator >= should return true if the current pitch is greater than or equal to the given pitch',
      () {
    // Arrange
    const pitch = Pitch.a4;
    // Act
    final isGreater = pitch >= Pitch.a3;
    // Assert
    expect(isGreater, true);
  });
  test(
      'Pitch operator >= should return true if the current pitch is equal to the given pitch',
      () {
    // Arrange
    const pitch = Pitch.a4;
    // Act
    final isEqual = pitch >= Pitch.a4;
    // Assert
    expect(isEqual, true);
  });
  test(
      'Pitch operator >= should return false if the current pitch is less than the given pitch',
      () {
    // Arrange
    const pitch = Pitch.a4;
    // Act
    final isLess = pitch >= Pitch.a5;
    // Assert
    expect(isLess, false);
  });
}
