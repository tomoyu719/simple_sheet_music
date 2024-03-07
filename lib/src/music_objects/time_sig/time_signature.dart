// class TimeSignature implements MusicObjectStyle {
//   // static const offsetHeightToY0 = 8.0;

//   void validation(String timeSignature) {
//     if (timeSignature.isEmpty) throw ArgumentError('time signature invalid');
//   }

//   // static TimeSignatureType getType() => throw UnimplementedError();

//   @override
//   final Color color;

//   @override
//   final EdgeInsets margin;

//   // C or C|
//   final String timeSignature;
//   TimeSignatureParser get parser => TimeSignatureParser(timeSignature);

//   const TimeSignature(
//     this.timeSignature, {
//     this.color = Colors.black,
//     this.margin = EdgeInsets.zero,
//   });

//   // Offset get numeratorOffset => throw UnimplementedError();
//   // Offset get denominatorOffset => throw UnimplementedError();

//   @override
//   MusicObjectPainter build(Stave stave) {
//     stave.currentObjectClef(this);
//     // return TimeSignatureCommonsPainter(
//     //     CommonTimeSignatureType.common, color, margin);
//     // return TimeSignatureCommonsPainter(
//     //     CommonTimeSignatureType.cutCommon, color, margin);
//     return parser.parseToPainter(color, renderOffset, this);
//     // final fractions =
//     //     TimeSignatureFractions(numerator: numerator, denominator: denominator)
//     // return TimeSignatureFractionPainter(fractions, color, renderOffset)

//     // validation(timeSignature);
//     // if (_isTimeSignatureCommon) {
//     //   return TimeSignatureCommonsPainter(
//     //       CommonTimeSignatureType.common, color, margin);
//     // } else if (_isTimeSignatureCutCommon) {
//     //   return TimeSignatureCommonsPainter(
//     //       CommonTimeSignatureType.cutCommon, color, margin);
//     // }
//     // // throw Error();
//     // final timeSigFractions = _parse(timeSignature);

//     // return TimeSignatureFractionPainter(
//     //     numerator: timeSigFractions.numerator,
//     //     denominator: timeSigFractions.denominator,
//     //     color: color,
//     //     margin: margin);
//   }

//   TimeSignatureMetrics get metrics => parser.parseToMetrics;

//   @override
//   double get width => metrics.width + margin.horizontal;
//   @override
//   double get upper => metrics.bbox.height / 2;

//   @override
//   double get lower => metrics.bbox.height / 2;

//   @override
//   MusicObjectPainter buildWithClef(Offset renderOffset, {ClefType? clefType}) =>
//       throw UnimplementedError();
// }
