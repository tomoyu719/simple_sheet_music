import 'package:simple_sheet_music/simple_sheet_music.dart';

enum ClefType {
  treble('uniE050', _trebleOffsetUnitHeight),
  alto('uniE05C', _altoOffsetUnitHeight),
  tenor('uniE05C', _tenorOffsetUnitHeight),
  bass('uniE062', _bassOffsetUnitHeight);

  const ClefType(this.pathKey, this.offsetUnitHeight);
  
  
  static const _trebleOffsetUnitHeight = 1;
  static const _altoOffsetUnitHeight = 0;
  static const _tenorOffsetUnitHeight = -1;
  static const _bassOffsetUnitHeight = -1;

  // static const _trebleSharpKeySignaturePositions = [4, 1, 5, 2, -1, 3, 0];
  // static const _altoSharpKeySignaturePositions = [3, 0, 4, 1, -2, 2, -1];
  // static const _tenorSharpKeySignaturePositions = [-2, 2, -1, 3, 0, 4, 1];
  // static const _bassSharpKeySignaturePositions = [2, -1, 3, 0, -3, 1, -2];

  // static const _trebleFlatKeySignaturePositions = [0, 3, -1, 2, -2, 1, -3];
  // static const _altoFlatKeySignaturePositions = [-1, 2, -2, 1, -3, 0, -4];
  // static const _tenorFlatKeySignaturePositions = [1, 4, 0, 3, -1, 2, -2];
  // static const _bassFlatKeySignaturePositions = [-2, 1, -3, 0, -4, -1, -5];

  // const ClefType(this.glyph, this.glyphBbox, this.offsetHeight,
  //     this.sharpKeySignaturePositions, this.flatKeySignaturePositions);
  final String pathKey;

  // final String glyph;
  // final Rect glyphBbox;
  final int offsetUnitHeight;
  // final List<int> sharpKeySignaturePositions;
  // final List<int> flatKeySignaturePositions;

  // int get positionOnCenter {
  //   switch (this) {
  //     case treble:
  //       return Pitch.b4.position;
  //     case alto:
  //       return Pitch.c4.position;
  //     case tenor:
  //       return Pitch.a3.position;
  //     case bass:
  //       return Pitch.d3.position;
  //   }
  // }

  // double get width => glyphBbox.width;
  // double get offsetX => -glyphBbox.left;
}
