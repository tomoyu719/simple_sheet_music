// import 'dart:ui';

// import '../../../mixins/position_mixin.dart';
// import '../../../mixins/text_paint_mixin.dart';
// import '../note_parts.dart';
// import 'note_stem.dart';
// import 'notehead_type.dart';

// class NoteHead with HasPosition, TextPaint implements NoteParts {
//   const NoteHead(this.noteHeadType, this.position, this.accidentalWidth);
//   final NoteHeadType noteHeadType;
//   final int position;
//   final double accidentalWidth;

//   Offset get _positionOffset => getPositionOffset(position);

//   Offset get _noteHeadOffset => _positionOffset + Offset(accidentalWidth, 0);

//   String get _glyph => noteHeadType.glyph;

//   Rect get bbox => noteHeadType.glyphBbox
//       .shift(Offset(accidentalWidth, positionOffsetHeight(position)));

//   double get width => bbox.width;

//   @override
//   double get upperHeight => -bbox.top;

//   @override
//   double get lowerHeight => bbox.bottom;

//   double noteFlagX({required bool isStemUp}) => isStemUp
//       ? accidentalWidth +
//           noteHeadType.stemUpRootRightBottom!.dx -
//           NoteStem.stemThickness
//       : accidentalWidth;

//   double initialX(Offset globalOffset) => globalOffset.dx + _noteHeadOffset.dx;

//   double get stemUpX =>
//       accidentalWidth +
//       noteHeadType.stemUpRootRightBottom!.dx -
//       NoteStem.stemThickness / 2;

//   double get stemDownX =>
//       accidentalWidth +
//       noteHeadType.stemDownRootLeftTop!.dx +
//       NoteStem.stemThickness / 2;

//   double get stemUpRootY =>
//       noteHeadType.stemUpRootRightBottom!.dy + positionOffsetHeight(position);

//   double get stemDownRootY =>
//       noteHeadType.stemDownRootLeftTop!.dy + positionOffsetHeight(position);

//   double get noteHeadCenterX => _noteHeadOffset.dx + width / 2;

//   void render(
//     Canvas canvas,
//     Size size,
//     Offset renderOffset,
//     Color color,
//     String fontFamily,
//   ) {
//     textPaint(
//       canvas,
//       size,
//       _glyph,
//       renderOffset + _noteHeadOffset,
//       color,
//       fontFamily,
//     );
//   }
// }
