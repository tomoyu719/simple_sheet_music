import 'dart:ui';

// import '../../../text_paint_mixin.dart';

enum ClefType {
  treble(_trebleGlyph, _trebleBbox, _trebleGlobalPositionOnCenter,
      _trebleOffsetHeight),
  alto(_altoGlyph, _altoBbox, _altoGlobalPositionOnCenter, _altoOffsetHeight),
  tenor(
      _altoGlyph, _altoBbox, _tenorGlobalPositionOnCenter, _tenorOffsetHeight),
  bass(_bassGlyph, _bassBbox, _bassGlobalPositionOnCenter, _bassOffsetHeight);

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

  static const _trebleGlobalPositionOnCenter = 29; //B4
  static const _altoGlobalPositionOnCenter = 23; //C4
  static const _tenorGlobalPositionOnCenter = 21; //A3
  static const _bassGlobalPositionOnCenter = 17; //D3

  const ClefType(this.glyph, this.glyphBbox, this.globalPositionOnCenter,
      this.offsetHeight);

  final String glyph;
  final Rect glyphBbox;
  final double offsetHeight;
  final int globalPositionOnCenter;

  double get width => glyphBbox.width;
  double get offsetX => -glyphBbox.left;
}
