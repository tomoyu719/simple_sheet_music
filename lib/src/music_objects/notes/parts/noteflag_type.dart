import 'dart:ui';

enum NoteFlagType {
  flag8th(
    upBbox: _flag8thUpGlyphBbox,
    upGlyph: _flag8thUpGlyph,
    upOffsetHeight: _flag8thUpOffsetHeight,
    downBbox: _flag8thDownGlyphBbox,
    downGlyph: _flag8thDownGlyph,
    downOffsetHeight: _flag8thDownOffsetHeight,
  ),
  flag16th(
    upBbox: _flag16thUpGlyphBbox,
    upGlyph: _flag16thUpGlyph,
    upOffsetHeight: _flag16thUpOffsetHeight,
    downBbox: _flag16thDownGlyphBbox,
    downGlyph: _flag16thDownGlyph,
    downOffsetHeight: _flag16thDownOffsetHeight,
  ),
  flag32th(
    upBbox: _flag32thUpGlyphBbox,
    upGlyph: _flag32thUpGlyph,
    upOffsetHeight: _flag32thUpOffsetHeight,
    downBbox: _flag32thDownGlyphBbox,
    downGlyph: _flag32thDownGlyph,
    downOffsetHeight: _flag32thDownOffsetHeight,
  ),
  flag64th(
    upBbox: _flag64thUpGlyphBbox,
    upGlyph: _flag64thUpGlyph,
    upOffsetHeight: _flag64thUpOffsetHeight,
    downBbox: _flag64thDownGlyphBbox,
    downGlyph: _flag64thDownGlyph,
    downOffsetHeight: _flag64thDownOffsetHeight,
  ),
  flag128th(
    upBbox: _flag128thUpGlyphBbox,
    upGlyph: _flag128thUpGlyph,
    upOffsetHeight: _flag128thUpOffsetHeight,
    downBbox: _flag128thDownGlyphBbox,
    downGlyph: _flag128thDownGlyph,
    downOffsetHeight: _flag128thDownOffsetHeight,
  );

  const NoteFlagType(
      {required this.upBbox,
      required this.downBbox,
      required this.upGlyph,
      required this.downGlyph,
      required this.upOffsetHeight,
      required this.downOffsetHeight});

  final Rect upBbox;
  final Rect downBbox;
  final String upGlyph;
  final String downGlyph;
  final double upOffsetHeight;
  final double downOffsetHeight;

  static const _flag8thUpGlyph = '';
  static const _flag8thDownGlyph = '';
  static const _flag16thUpGlyph = '';
  static const _flag16thDownGlyph = '';
  static const _flag32thUpGlyph = '';
  static const _flag32thDownGlyph = '';
  static const _flag64thUpGlyph = '';
  static const _flag64thDownGlyph = '';
  static const _flag128thUpGlyph = '';
  static const _flag128thDownGlyph = '';

  static const _flag8thUpGlyphBbox =
      Rect.fromLTRB(0.0, -0.03521239682756091, 1.056, 3.240768470618394);
  static const _flag8thDownGlyphBbox =
      Rect.fromLTRB(0.0, -3.232896633157715, 1.224, 0.0575672);
  static const _flag16thUpGlyphBbox = Rect.fromLTRB(0.0, -0.008, 1.116, 3.252);
  static const _flag16thDownGlyphBbox = Rect.fromLTRB(-1.9418183745617774e-05,
      -3.2480256, 1.1635806326044895, 0.03601094374150052);
  static const _flag32thUpGlyphBbox = Rect.fromLTRB(0.0, -0.596, 1.044, 3.248);
  static const _flag32thDownGlyphBbox =
      Rect.fromLTRB(0.0, -3.248, 1.092, 0.687477099907407);
  static const _flag64thUpGlyphBbox =
      Rect.fromLTRB(0.0, -1.387108, 1.044, 3.248);
  static const _flag64thDownGlyphBbox =
      Rect.fromLTRB(0.0, -3.248, 1.092, 1.5040263329569774);
  static const _flag128thDownGlyphBbox =
      Rect.fromLTRB(0.0, -3.248, 1.092, 2.320034471092627);
  static const _flag128thUpGlyphBbox =
      Rect.fromLTRB(0.0, -2.1320003247537183, 1.044, 3.248);

  // double get _upOffsetHeightToY0 => -upBbox.top;
  // double get downOffsetHeightToY0 => -upBbox.bottom;

  static const _flag8thUpOffsetHeight = 0.04;
  static const _flag8thDownOffsetHeight = -0.132;
  static const _flag16thUpOffsetHeight = 0.088;
  static const _flag16thDownOffsetHeight = -0.128;
  static const _flag32thUpOffsetHeight = 0.376;
  static const _flag32thDownOffsetHeight = -0.448;
  static const _flag64thUpOffsetHeight = 1.172;
  static const _flag64thDownOffsetHeight = -1.244;
  static const _flag128thUpOffsetHeight = 1.9;
  static const _flag128thDownOffsetHeight = -2.076;
}
