// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:simple_sheet_music/src/music_object_interfaces.dart';

// import 'package:simple_sheet_music/src/music_object_painter.dart';
// import 'package:simple_sheet_music/src/text_paint_mixin.dart';

// import '../../../box_paint_mixin.dart';
// import 'time_signature_part.dart';

// class TimeSignatureCommonsPainter
//     with TextPaint, BoxPaint
//     implements MusicObjectPainter {
//   // final CommonTimeSignatureType type;
//   final Color color;
//   static const bboxOffsetHeight = 8.0;

//   TimeSignatureCommonsPainter(
//       this.glyph, this.bbox, this.color, this.renderOffset, this.musicObject);
//   final String glyph;

//   @override
//   void render(Canvas canvas, Size size, Offset offset) {
//     renderOffset = offset;
//     textPaint(canvas, size, glyph, renderOffset, color);
//     boxPaint(canvas, size, renderArea);
//   }

//   @override
//   bool isHit(Offset position) => renderArea.contains(position);

//   @override
//   Rect get renderArea =>
//       // type.bbox.shift(renderOffset);
//       bbox.shift(renderOffset + const Offset(0, bboxOffsetHeight));

//   @override
//   late final Offset renderOffset;

//   @override
//   final MusicObjectStyle musicObject;

//   @override
//   final Rect bbox;
// }
