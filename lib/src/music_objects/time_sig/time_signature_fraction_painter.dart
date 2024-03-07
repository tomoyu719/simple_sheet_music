// import 'package:flutter/material.dart';
// import 'package:simple_sheet_music/src/music_object_interfaces.dart';
// import 'package:simple_sheet_music/src/music_object_painter.dart';
// import 'package:simple_sheet_music/src/music_objects/glyphs/time_sig/time_signature_part.dart';
// import 'package:simple_sheet_music/src/text_paint_mixin.dart';

// import '../../../box_paint_mixin.dart';

// // TODO List<TimeSignatureNum> to be class

// class TimeSignatureFractionPainter
//     with TextPaint, BoxPaint
//     implements MusicObjectPainter {
//   final Color color;

//   static const bboxOffset = Offset(0, 4);

//   const TimeSignatureFractionPainter(
//       this.fractions, this.color, this.renderOffset, this.musicObject);
//   // bool get isTimeSigTwoDigits => throw UnimplementedError();
//   Offset get numeratorOffset => Offset(numeratorOffsetX, 0);
//   Offset get denominatorOffset => Offset(denominatorOffsetX, 0);
//   double get numeratorOffsetX => numerator.width <= denominator.width
//       ? denominatorHalfWidth - numeratorHalfWidth
//       : 0.0;
//   // double get denominatorOffsetX => denominator.width > numerator.width  ? : ;
//   double get denominatorOffsetX => denominator.width <= numerator.width
//       ? numeratorHalfWidth - denominatorHalfWidth
//       : 0.0;

//   double get numeratorHalfWidth => numerator.width / 2;
//   double get denominatorHalfWidth => denominator.width / 2;

//   // void renderDenominator() {

//   // }

//   // void renderNumerator() {

//   // }

//   // bool get isTwoDigits => throw UnimplementedError();
//   // bool get isTwoDigits => throw UnimplementedError();
//   // bool get isTwoDigits => throw UnimplementedError();
//   // final List<TimeSignatureNum> numerator;
//   // final List<TimeSignatureNum> denominator;
//   final TimeSignatureFractions fractions;
//   double partsWidth(List<TimeSignatureNum> part) =>
//       part.fold(0.0, (previousValue, element) => previousValue + element.width);

//   // List<TimeSignatureNum> get widerParts =>
//   //     partsWidth(numerator) >= partsWidth(denominator)
//   //         ? numerator
//   //         : denominator;
//   // List<TimeSignatureNum> get narrowerParts =>
//   //     partsWidth(numerator) <= partsWidth(denominator)
//   //         ? numerator
//   //         : denominator;

//   // double get widerPartHalfWidth => partsWidth(widerParts) / 2;
//   // double get narrowerPartsHalfWidth => partsWidth(narrowerParts) / 2;

//   // double xOffset(List<TimeSignatureNum> part) => part == widerParts
//   //     ? margin.left
//   //     : margin.left + widerPartHalfWidth - narrowerPartsHalfWidth;

//   void renderParts(Canvas canvas, Size size, Offset renderOffset,
//       TimeSignatureFractionPart part) {
//     double xOffset = 0;
//     for (var num in part.nums) {
//       textPaint(
//           canvas, size, num.glyph, renderOffset + Offset(xOffset, 0), color);
//       xOffset += num.width;
//     }
//   }

//   TimeSignatureFractionPart get numerator => fractions.numerator;
//   TimeSignatureFractionPart get denominator => fractions.denominator;

//   @override
//   void render(Canvas canvas, Size size) {
//     renderParts(canvas, size, renderOffset + numeratorOffset, numerator);
//     renderParts(canvas, size, renderOffset + denominatorOffset, denominator);
//     boxPaint(canvas, size, renderArea);
//   }

//   @override
//   bool isHit(Offset position) => renderArea.contains(position);

//   @override
//   Rect get renderArea => bbox.shift(renderOffset + bboxOffset);

//   @override
//   final Offset renderOffset;

//   @override
//   final MusicObjectStyle musicObject;

//   @override
//   Rect get bbox => fractions.bbox;
// }
