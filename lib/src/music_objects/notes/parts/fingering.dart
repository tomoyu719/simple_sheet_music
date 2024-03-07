import 'dart:math';
import 'dart:ui';

import 'package:simple_sheet_music/src/measure/staffline.dart';

import '../../../mixins/position_mixin.dart';
import '../../../mixins/text_paint_mixin.dart';
import '../note_parts.dart';

class FingeringRenderer with TextPaint, HasPosition implements NoteParts {
  final Fingering fingeringType;
  final double noteUpperHeight;
  final double noteHeadCenterX;

  const FingeringRenderer(this.fingeringType,
      {required this.noteUpperHeight, required this.noteHeadCenterX});

  double get _fingeringOffsetX => noteHeadCenterX - _width / 2;

  double get _fingerOffsetY =>
      -max(noteUpperHeight, StaffLineRenderer.upperToCenterHeight) -
      _spacingHeight;
  double get _spacingHeight => height / 2;

  Offset get _fingeringOffset => Offset(_fingeringOffsetX, _fingerOffsetY);
  double get height => fingeringType.height;
  double get _width => fingeringType.width;
  @override
  double get upperHeight => -_bbox.top;
  @override
  double get lowerHeight => _bbox.bottom;
  String get _glyph => fingeringType.glyph;
  Rect get _bbox => fingeringType.bbox.shift(_fingeringOffset);

  render(Canvas canvas, Size size, Offset renderOffset, Color color,
      String fontFamily) {
    textPaint(canvas, size, _glyph, renderOffset + _fingeringOffset, color,
        fontFamily);
  }
}

enum Fingering {
  thumb(_thumbGlyph, _thumbBbox),
  zero(_zeroGlyph, _zeroBbox),
  one(_oneGlyph, _oneBbox),
  two(_twoGlyph, _twoBbox),
  three(_threeGlyph, _threeBbox),
  four(_fourGlyph, _fourBbox),
  five(_fiveGlyph, _fiveBbox);

  const Fingering(this.glyph, this.bbox);

  final String glyph;
  final Rect bbox;

  double get width => bbox.width;
  double get height => bbox.height;

  static const _thumbGlyph = '';
  static const _zeroGlyph = '';
  static const _oneGlyph = '';
  static const _twoGlyph = '';
  static const _threeGlyph = '';
  static const _fourGlyph = '';
  static const _fiveGlyph = '';

  static const _thumbBbox = Rect.fromLTRB(0.0, -1.24, 0.716, 0.0);
  static const _zeroBbox =
      Rect.fromLTRB(0.08, -1.004, 0.8009123751085776, 0.004);
  static const _oneBbox =
      Rect.fromLTRB(0.07920548073794899, -0.988, 0.668, 0.0);
  static const _twoBbox =
      Rect.fromLTRB(0.08, -0.952, 0.8327411619664543, 0.0037652081134236966);
  static const _threeBbox =
      Rect.fromLTRB(0.08, -1.0060901699437494, 0.808, 0.0);
  static const _fourBbox =
      Rect.fromLTRB(0.07843078061834695, -1.1, 0.728, 0.052);
  static const _fiveBbox = Rect.fromLTRB(0.08, -1.04, 0.828, 0.0);
}
