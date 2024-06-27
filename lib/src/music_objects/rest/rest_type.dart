import 'dart:ui';

import 'package:simple_sheet_music/src/measure/staffline.dart';

enum RestType {
  whole(128, _restWholeGlyph, _restWholeGlyphBbox),
  half(64, _restHalfGlyph, _restHalfGlyphBbox),
  quarter(32, _restQuarterGlyph, _restQuarterGlyphBbox),
  eighth(16, _rest8thGlyph, _rest8thGlyphBbox),
  sixteenth(8, _rest16thGlyph, _rest16thGlyphBbox),
  thirtySecond(4, _rest32ndGlyph, _rest32ndGlyphBbox),
  sixtyFourth(2, _rest64thGlyph, _rest64thGlyphBbox),
  oneHundredsTwentyEighth(1, _rest128thGlyph, _rest128thGlyphBbox);

  const RestType(this.time, this.glyph, this.bbox);

  final int time;
  final String glyph;
  final Rect bbox;

  double get offsetX => -bbox.left;
  double get offsetY {
    switch (this) {
      case whole:
        return -StaffLineRenderer.staffLineSpaceHeight;
      case half:
      case quarter:
      case eighth:
      case sixteenth:
      case thirtySecond:
      case sixtyFourth:
      case oneHundredsTwentyEighth:
        return 0;
    }
  }

  static const _restWholeGlyph = '';
  static const _restHalfGlyph = '';
  static const _restQuarterGlyph = '𝄽';
  static const _rest8thGlyph = '𝄾';
  static const _rest16thGlyph = '𝄿';
  static const _rest32ndGlyph = '𝅀';
  static const _rest64thGlyph = '𝅁';
  static const _rest128thGlyph = '𝅂';

  static const _restWholeGlyphBbox = Rect.fromLTRB(0, -0.036, 1.128, 0.54);
  static const _restHalfGlyphBbox = Rect.fromLTRB(0, -0.568, 1.128, 0.008);
  static const _restQuarterGlyphBbox = Rect.fromLTRB(0.004, -1.492, 1.08, 1.5);
  static const _rest8thGlyphBbox = Rect.fromLTRB(0, -0.696, 0.988, 1.004);
  static const _rest16thGlyphBbox = Rect.fromLTRB(0, -0.716, 1.28, 2);
  static const _rest32ndGlyphBbox = Rect.fromLTRB(0, -1.704, 1.452, 2);
  static const _rest64thGlyphBbox = Rect.fromLTRB(0, -1.72, 1.692, 3.012);
  static const _rest128thGlyphBbox = Rect.fromLTRB(0, -2.756, 1.94, 3);
}
