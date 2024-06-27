// import 'dart:math';
// import 'dart:ui';

// enum CommonTimeSignatureType implements TimeSignatureMetrics {
//   common(glyph: commonGlyph, bbox: commonBbox),
//   cutCommon(glyph: cutCommonGlyph, bbox: cutCommonBbox);

//   const CommonTimeSignatureType({required this.glyph, required this.bbox});
//   static const commonGlyph = '';
//   static const cutCommonGlyph = '';
//   static const commonBbox = Rect.fromLTRB(0.02, 1.004, 1.696, -0.996);
//   static const cutCommonBbox = Rect.fromLTRB(0, 1.444, 1.672, -1.436);

//   final String glyph;
//   @override
//   final Rect bbox;
//   @override
//   double get width => bbox.width;
// }

// class TimeSignatureFractionPart {
//   const TimeSignatureFractionPart(this.nums);
//   final List<TimeSignatureNum> nums;
//   // bool get isTwoDigits => nums.length == 2;
//   double get left => nums.first.bbox.left;
//   double get right =>
//       nums.fold(0, (previousValue, element) => previousValue + element.width);
//   double get top => nums.fold(
//         nums.first.bbox.top,
//         (previousValue, element) => max(previousValue, element.bbox.top),
//       );
//   double get bottom => nums.fold(
//         nums.first.bbox.bottom,
//         (previousValue, element) => min(previousValue, element.bbox.bottom),
//       );
//   Rect get bbox => Rect.fromLTRB(left, top, right, bottom);

//   double get width =>
//       nums.fold(0, (previousValue, element) => previousValue + element.width);
//   // double get upper => part.fold(
//   //     0.0, (previousValue, element) => max(previousValue, element.bbox.top));
//   // double get lower => part.fold(
//   //     0.0, (previousValue, element) => max(previousValue, element.bbox.bottom));
//   // Rect get bbox => throw UnimplementedError();
// }

// class TimeSignatureFractions implements TimeSignatureMetrics {
//   const TimeSignatureFractions({
//     required this.numerator,
//     required this.denominator,
//   });
//   final TimeSignatureFractionPart numerator;
//   final TimeSignatureFractionPart denominator;

//   @override
//   Rect get bbox => Rect.fromLTRB(left, top, right, bottom);

//   double get left =>
//       numerator.left < denominator.left ? numerator.left : denominator.left;
//   double get right =>
//       numerator.right > denominator.left ? numerator.right : denominator.right;
//   double get top => numerator.top;
//   double get bottom => denominator.bottom;

//   @override
//   double get width => max(numerator.width, denominator.width);
// }

// abstract class TimeSignatureMetrics {
//   double get width;
//   Rect get bbox;
//   // double get top;
//   // double get bottom;
// }

// abstract class TimeSignatureNum {
//   double get width;
//   String get glyph;
//   Rect get bbox;
// }

// enum TimeSignatureDenominatorNum implements TimeSignatureNum {
//   zero(glyph: zeroGlyph, bbox: zeroBbox),
//   one(glyph: oneGlyph, bbox: oneBbox),
//   two(glyph: twoGlyph, bbox: twoBbox),
//   three(glyph: threeGlyph, bbox: threeBbox),
//   four(glyph: fourGlyph, bbox: fourBbox),
//   five(glyph: fiveGlyph, bbox: fiveBbox),
//   six(glyph: sixGlyph, bbox: sixBbox),
//   seven(glyph: sevenGlyph, bbox: sevenBbox),
//   eight(glyph: eightGlyph, bbox: eightBbox),
//   nine(glyph: nineGlyph, bbox: nineBbox);

//   const TimeSignatureDenominatorNum({required this.glyph, required this.bbox});
//   factory TimeSignatureDenominatorNum.fromNumber(String number) {
//     switch (number) {
//       case '0':
//         return zero;
//       case '1':
//         return one;
//       case '2':
//         return two;
//       case '3':
//         return three;
//       case '4':
//         return four;
//       case '5':
//         return five;
//       case '6':
//         return six;
//       case '7':
//         return seven;
//       case '8':
//         return eight;
//       case '9':
//         return nine;
//       default:
//         throw RangeError('invalid time signature');
//     }
//   }

//   static const zeroGlyph = '';
//   static const oneGlyph = '';
//   static const twoGlyph = '';
//   static const threeGlyph = '';
//   static const fourGlyph = '';
//   static const fiveGlyph = '';
//   static const sixGlyph = '';
//   static const sevenGlyph = '';
//   static const eightGlyph = '';
//   static const nineGlyph = '';

//   static const zeroBbox = Rect.fromLTRB(0, 2.004, 1.72, 0);
//   static const oneBbox = Rect.fromLTRB(0, 2.004, 1.176, 0);
//   static const twoBbox = Rect.fromLTRB(0, 2.016, 1.624, -0.028);
//   static const threeBbox = Rect.fromLTRB(0, 1.996, 1.524, -0.004);
//   static const fourBbox = Rect.fromLTRB(0, 2.004, 1.72, 0);
//   static const fiveBbox = Rect.fromLTRB(0.08, 1.984, 1.532, -0.004);
//   static const sixBbox = Rect.fromLTRB(0.08, 2.004, 1.656, 0.004);
//   static const sevenBbox = Rect.fromLTRB(0.08, 1.996, 1.684, 0);
//   static const eightBbox = Rect.fromLTRB(0.08, 2.036, 1.664, -0.036);
//   static const nineBbox = Rect.fromLTRB(0.08, 1.996, 1.656, -0.004);

//   @override
//   final String glyph;
//   @override
//   double get width => bbox.width;
//   @override
//   final Rect bbox;
// }

// enum TimeSignatureNumeratorNum implements TimeSignatureNum {
//   zero(glyph: zeroGlyph, bbox: zeroBbox),
//   one(glyph: oneGlyph, bbox: oneBbox),
//   two(glyph: twoGlyph, bbox: twoBbox),
//   three(glyph: threeGlyph, bbox: threeBbox),
//   four(glyph: fourGlyph, bbox: fourBbox),
//   five(glyph: fiveGlyph, bbox: fiveBbox),
//   six(glyph: sixGlyph, bbox: sixBbox),
//   seven(glyph: sevenGlyph, bbox: sevenBbox),
//   eight(glyph: eightGlyph, bbox: eightBbox),
//   nine(glyph: nineGlyph, bbox: nineBbox);

//   const TimeSignatureNumeratorNum({required this.glyph, required this.bbox});

//   factory TimeSignatureNumeratorNum.fromNumber(String number) {
//     switch (number) {
//       case '0':
//         return zero;
//       case '1':
//         return one;
//       case '2':
//         return two;
//       case '3':
//         return three;
//       case '4':
//         return four;
//       case '5':
//         return five;
//       case '6':
//         return six;
//       case '7':
//         return seven;
//       case '8':
//         return eight;
//       case '9':
//         return nine;
//       default:
//         throw RangeError('invalid time signature');
//     }
//   }

//   static const zeroGlyph = '';
//   static const oneGlyph = '';
//   static const twoGlyph = '';
//   static const threeGlyph = '';
//   static const fourGlyph = '';
//   static const fiveGlyph = '';
//   static const sixGlyph = '';
//   static const sevenGlyph = '';
//   static const eightGlyph = '';
//   static const nineGlyph = '';

//   static const zeroBbox = Rect.fromLTRB(0, 4.004, 1.72, 2);
//   static const oneBbox = Rect.fromLTRB(0, 4.004, 1.176, 2);
//   static const twoBbox = Rect.fromLTRB(0, 4.016, 1.624, 1.972);
//   static const threeBbox = Rect.fromLTRB(0, 3.996, 1.524, 1.996);
//   static const fourBbox = Rect.fromLTRB(0, 4.004, 1.72, 2);
//   static const fiveBbox = Rect.fromLTRB(0.08, 3.984, 1.532, 1.996);
//   static const sixBbox = Rect.fromLTRB(0.08, 4.004, 1.656, 2.004);
//   static const sevenBbox = Rect.fromLTRB(0.08, 3.996, 1.684, 2);
//   static const eightBbox = Rect.fromLTRB(0.08, 4.036, 1.664, 1.964);
//   static const nineBbox = Rect.fromLTRB(0.08, 3.996, 1.656, 1.996);

//   @override
//   final String glyph;
//   @override
//   double get width => bbox.width;
//   @override
//   final Rect bbox;
// }
