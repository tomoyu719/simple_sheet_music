import 'dart:ui';

import '../../../mixins/text_paint_mixin.dart';
import '../note_parts.dart';
import 'note_stem.dart';
import 'noteflag_type.dart';
import 'notehead.dart';

class NoteFlag with TextPaint implements NoteParts {
  final NoteHead noteHead;
  final NoteFlagType noteFlagType;
  final bool isUpStem;
  final bool isFlagOnCenter;

  const NoteFlag(
      this.noteHead, this.noteFlagType, this.isUpStem, this.isFlagOnCenter);

  String get _glyph => isUpStem ? noteFlagType.upGlyph : noteFlagType.downGlyph;

  Rect get bbox => isUpStem
      ? noteFlagType.upBbox.shift(offset)
      : noteFlagType.downBbox.shift(offset);

  @override
  double get upperHeight => bbox.top.abs();

  @override
  double get lowerHeight => bbox.bottom.abs();

  double get stemTipY => isUpStem
      ? _upFlagOffsetY + noteFlagType.upOffsetHeight
      : _downFlagOffsetY + noteFlagType.downOffsetHeight;

  double get _upFlagOffsetY => isFlagOnCenter
      ? noteFlagType.upBbox.top
      : noteHead.stemUpRootY - NoteStem.minStemLength;

  double get _downFlagOffsetY => isFlagOnCenter
      ? -noteFlagType.downBbox.bottom
      : noteHead.stemUpRootY + NoteStem.minStemLength;

  double get _offsetX => noteHead.noteFlagX(isUpStem);

  double get _offsetY => isUpStem ? _upFlagOffsetY : _downFlagOffsetY;

  Offset get offset => Offset(_offsetX, _offsetY);

  double get width => bbox.width;

  render(Canvas canvas, Size size, Offset renderOffset, Color color,
      String fontFamily) {
    textPaint(canvas, size, _glyph, renderOffset + offset, color, fontFamily);
  }
}
