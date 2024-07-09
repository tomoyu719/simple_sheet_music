import 'package:simple_sheet_music/src/music_objects/notes/note_pitch.dart';

/// Enum representing different types of clefs.
enum ClefType {
  /// Treble clef.
  treble(
    'uniE050',
    _trebleOffsetSpace,
    sharpKeySignaturePositions: _trebleSharpKeySignaturePositions,
    flatKeySignaturePositions: _trebleFlatKeySignaturePositions,
  ),

  /// Alto clef.
  alto(
    'uniE05C',
    _altoOffsetSpace,
    sharpKeySignaturePositions: _altoSharpKeySignaturePositions,
    flatKeySignaturePositions: _altoFlatKeySignaturePositions,
  ),

  /// Tenor clef.
  tenor(
    'uniE05C',
    _tenorOffsetSpace,
    sharpKeySignaturePositions: _tenorSharpKeySignaturePositions,
    flatKeySignaturePositions: _tenorFlatKeySignaturePositions,
  ),

  /// Bass clef.
  bass(
    'uniE062',
    _bassOffsetSpace,
    sharpKeySignaturePositions: _bassSharpKeySignaturePositions,
    flatKeySignaturePositions: _bassFlatKeySignaturePositions,
  );

  const ClefType(
    this.pathKey,
    this.offsetSpace, {
    required this.sharpKeySignaturePositions,
    required this.flatKeySignaturePositions,
  });

  static const _trebleOffsetSpace = 1;
  static const _altoOffsetSpace = 0;
  static const _tenorOffsetSpace = -1;
  static const _bassOffsetSpace = -1;

  static const _trebleSharpKeySignaturePositions = [4, 1, 5, 2, -1, 3, 0];
  static const _altoSharpKeySignaturePositions = [3, 0, 4, 1, -2, 2, -1];
  static const _tenorSharpKeySignaturePositions = [-2, 2, -1, 3, 0, 4, 1];
  static const _bassSharpKeySignaturePositions = [2, -1, 3, 0, -3, 1, -2];

  static const _trebleFlatKeySignaturePositions = [0, 3, -1, 2, -2, 1, -3];
  static const _altoFlatKeySignaturePositions = [-1, 2, -2, 1, -3, 0, -4];
  static const _tenorFlatKeySignaturePositions = [1, 4, 0, 3, -1, 2, -2];
  static const _bassFlatKeySignaturePositions = [-2, 1, -3, 0, -4, -1, -5];

  final String pathKey;

  /// The [offsetSpace] property represents the number of spaces the clef is offset from the default position.
  final int offsetSpace;
  final List<int> sharpKeySignaturePositions;
  final List<int> flatKeySignaturePositions;

  /// Returns the position of the clef on the center line of the staff.
  int get positionOnCenter {
    switch (this) {
      case treble:
        return Pitch.b4.position;
      case alto:
        return Pitch.c4.position;
      case tenor:
        return Pitch.a3.position;
      case bass:
        return Pitch.d3.position;
    }
  }
}
