import 'dart:ui';

enum Accidental {
  natural(_naturalGlyph, _naturalBbox),
  sharp(_sharpGlyph, _sharpBbox),
  doubleSharp(_doubleSharpGlyph, _doubleSharpBbox),
  flat(_flatGlyph, _flatBbox),
  doubleFlat(_doubleFlatpGlyph, _doubleFlatBbox);

  const Accidental(this.glyph, this.bbox);

  final String glyph;
  final Rect bbox;
  double get width => bbox.width;

  static const _naturalBbox = Rect.fromLTRB(0, -1.364, 0.672, 1.34);
  static const _sharpBbox = Rect.fromLTRB(0, -1.4, 0.996, 1.392);
  static const _doubleSharpBbox = Rect.fromLTRB(0, -0.508, 0.988, 0.5);
  static const _flatBbox = Rect.fromLTRB(0, -1.756, 0.904, 0.7);
  static const _doubleFlatBbox = Rect.fromLTRB(0, -1.748, 1.644, 0.7);

  static const _naturalGlyph = '♮';
  static const _sharpGlyph = '♯';
  static const _doubleSharpGlyph = '𝄪';
  static const _flatGlyph = '♭';
  static const _doubleFlatpGlyph = '𝄫';
}
