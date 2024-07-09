import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/notes/note_pitch.dart';

void main() {
  test('ClefType.treble should return the correct position on center', () {
    // Arrange
    const clefType = ClefType.treble;
    // Act
    final positionOnCenter = clefType.positionOnCenter;
    // Assert
    expect(positionOnCenter, Pitch.b4.position);
  });
  test('ClefType.alto should return the correct position on center', () {
    // Arrange
    const clefType = ClefType.alto;
    // Act
    final positionOnCenter = clefType.positionOnCenter;
    // Assert
    expect(positionOnCenter, Pitch.c4.position);
  });
  test('ClefType.tenor should return the correct position on center', () {
    // Arrange
    const clefType = ClefType.tenor;
    // Act
    final positionOnCenter = clefType.positionOnCenter;
    // Assert
    expect(positionOnCenter, Pitch.a3.position);
  });
  test('ClefType.bass should return the correct position on center', () {
    // Arrange
    const clefType = ClefType.bass;
    // Act
    final positionOnCenter = clefType.positionOnCenter;
    // Assert
    expect(positionOnCenter, Pitch.d3.position);
  });
}
