// import 'package:flutter/material.dart';
// import 'package:simple_sheet_music/simple_sheet_music.dart';
// import 'package:simple_sheet_music/src/music_objects/glyphs/time_sig/time_signature_common_painter.dart';
// import 'package:simple_sheet_music/src/music_objects/glyphs/time_sig/time_signature_fraction_painter.dart';
// import 'package:simple_sheet_music/src/music_objects/glyphs/time_sig/time_signature_part.dart';

// import '../../../music_object_painter.dart';

// class TimeSignatureParser {
//   // TODO  validate
//   final String timeSignatureStr;
//   const TimeSignatureParser(this.timeSignatureStr);

//   double get commonsOffsetHeightToY0 => 8.0;
//   Offset get commonsOffsetToY0 => Offset(0, -commonsOffsetHeightToY0);
//   double get fractionOffsetHeightToY0 => 6.0;
//   Offset get fractionOffsetToY0 => Offset(0, -fractionOffsetHeightToY0);
//   // TODO fix
//   MusicObjectPainter parseToPainter(
//       Color color, Offset renderOffset, TimeSignature timeSignature) {
//     if (_isTimeSignatureCommons) {
//       final type = commonType!;
//       return TimeSignatureCommonsPainter(type.glyph, type.bbox, color,
//           renderOffset + commonsOffsetToY0, timeSignature);
//     }
//     return TimeSignatureFractionPainter(parseToFractions, color,
//         renderOffset + fractionOffsetToY0, timeSignature);
//   }

//   TimeSignatureMetrics get parseToMetrics {
//     if (_isTimeSignatureCommon) {
//       return CommonTimeSignatureType.common;
//     } else if (_isTimeSignatureCutCommon) {
//       return CommonTimeSignatureType.cutCommon;
//     }
//     return parseToFractions;
//   }

//   CommonTimeSignatureType? get commonType {
//     if (_isTimeSignatureCommon) {
//       return CommonTimeSignatureType.common;
//     } else if (_isTimeSignatureCutCommon) {
//       return CommonTimeSignatureType.cutCommon;
//     }

//     return null;
//   }

//   bool get _isTimeSignatureCommons =>
//       _isTimeSignatureCommon || _isTimeSignatureCutCommon;

//   bool get _isTimeSignatureCommon => timeSignatureStr == 'C';

//   bool get _isTimeSignatureCutCommon => timeSignatureStr == 'C|';

//   bool _isTwoDigits(String number) => number.length == 2;

//   TimeSignatureFractions get parseToFractions {
//     final fractionStr = timeSignatureStr.split('/');
//     final numeratorStr = fractionStr.first;
//     final denominatorStr = fractionStr.last;
//     final numerator = _parseToPart(numeratorStr, isNumerator: true);
//     final denominator = _parseToPart(denominatorStr, isNumerator: false);
//     return TimeSignatureFractions(
//         numerator: numerator, denominator: denominator);
//   }

//   TimeSignatureFractionPart _parseToPart(String timeSignaturePart,
//       {bool isNumerator = false}) {
//     if (isNumerator) {
//       return _isTwoDigits(timeSignaturePart)
//           ? TimeSignatureFractionPart([
//               TimeSignatureNumeratorNum.fromNumber(timeSignaturePart[0]),
//               TimeSignatureNumeratorNum.fromNumber(timeSignaturePart[1])
//             ])
//           : TimeSignatureFractionPart(
//               [TimeSignatureNumeratorNum.fromNumber(timeSignaturePart)]);
//     }
//     return _isTwoDigits(timeSignaturePart)
//         ? TimeSignatureFractionPart([
//             TimeSignatureDenominatorNum.fromNumber(timeSignaturePart[0]),
//             TimeSignatureDenominatorNum.fromNumber(timeSignaturePart[1])
//           ])
//         : TimeSignatureFractionPart(
//             [TimeSignatureDenominatorNum.fromNumber(timeSignaturePart)]);
//   }
// }
