import 'dart:ui';

import '../../../mixins/position_mixin.dart';
import '../../../mixins/text_paint_mixin.dart';
import 'accidental.dart';

class AccidentalRenderer with HasPosition, TextPaint {
  final Accidental accidentalType;
  final int position;
  const AccidentalRenderer(this.accidentalType, this.position);
  Offset get _positionOffset => getPositionOffset(position);
  double get width => accidentalType.width;
  double get upperHeight => -bbox.top;
  double get lowerHeight => bbox.bottom;
  String get _glyph => accidentalType.glyph;
  Rect get bbox => accidentalType.bbox.shift(_positionOffset);

  render(Canvas canvas, Size size, Offset renderOffset, Color color,
      String fontFamily) {
    textPaint(canvas, size, _glyph, renderOffset + _positionOffset, color,
        fontFamily);
  }
}
