import 'dart:ui';

import 'package:simple_sheet_music/simple_sheet_music.dart';

enum ClefType {
  treble(_trebleGlyph, _trebleBbox, _trebleOffsetHeight,
      _trebleSharpKeySignaturePositions, _trebleFlatKeySignaturePositions),
  alto(_altoGlyph, _altoBbox, _altoOffsetHeight,
      _altoSharpKeySignaturePositions, _altoFlatKeySignaturePositions),
  tenor(_altoGlyph, _altoBbox, _tenorOffsetHeight,
      _tenorSharpKeySignaturePositions, _tenorFlatKeySignaturePositions),
  bass(_bassGlyph, _bassBbox, _bassOffsetHeight,
      _bassSharpKeySignaturePositions, _bassFlatKeySignaturePositions);

  static const _trebleGlyph = '';
  static const _altoGlyph = '';
  static const _bassGlyph = '';

  static const _trebleBbox = Rect.fromLTRB(0.0, -4.392, 2.684, 2.632);
  static const _altoBbox = Rect.fromLTRB(0.0, -2.024, 2.796, 2.024);
  static const _bassBbox = Rect.fromLTRB(-0.02, -1.048, 2.736, 2.54);

  static const _trebleOffsetHeight = 1.0;
  static const _altoOffsetHeight = 0.0;
  static const _tenorOffsetHeight = -1.0;
  static const _bassOffsetHeight = -1.0;

  static const _trebleSharpKeySignaturePositions = [4, 1, 5, 2, -1, 3, 0];
  static const _altoSharpKeySignaturePositions = [3, 0, 4, 1, -2, 2, -1];
  static const _tenorSharpKeySignaturePositions = [-2, 2, -1, 3, 0, 4, 1];
  static const _bassSharpKeySignaturePositions = [2, -1, 3, 0, -3, 1, -2];

  static const _trebleFlatKeySignaturePositions = [0, 3, -1, 2, -2, 1, -3];
  static const _altoFlatKeySignaturePositions = [-1, 2, -2, 1, -3, 0, -4];
  static const _tenorFlatKeySignaturePositions = [1, 4, 0, 3, -1, 2, -2];
  static const _bassFlatKeySignaturePositions = [-2, 1, -3, 0, -4, -1, -5];

  const ClefType(this.glyph, this.glyphBbox, this.offsetHeight,
      this.sharpKeySignaturePositions, this.flatKeySignaturePositions);

  final String glyph;
  final Rect glyphBbox;
  final double offsetHeight;
  final List<int> sharpKeySignaturePositions;
  final List<int> flatKeySignaturePositions;

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

  double get width => glyphBbox.width;
  double get offsetX => -glyphBbox.left;
}
