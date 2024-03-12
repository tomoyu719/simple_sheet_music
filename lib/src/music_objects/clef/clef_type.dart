import 'dart:ui';

import 'package:simple_sheet_music/simple_sheet_music.dart';

// import '../../../text_paint_mixin.dart';

enum ClefType {
  treble(_trebleGlyph, _trebleBbox, _trebleOffsetHeight),
  alto(_altoGlyph, _altoBbox, _altoOffsetHeight),
  tenor(_altoGlyph, _altoBbox, _tenorOffsetHeight),
  bass(_bassGlyph, _bassBbox, _bassOffsetHeight);

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

  const ClefType(this.glyph, this.glyphBbox, this.offsetHeight);

  final String glyph;
  final Rect glyphBbox;
  final double offsetHeight;

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
