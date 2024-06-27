// import 'dart:ui';

// enum NoteHeadType {
//   whole(_wholeGlyph, _wholeBbox, hasStem: false),
//   half(
//     _halfGlyph,
//     _halfBbox,
//     hasStem: true,
//     stemUpRootRightBottom: _halfStemUpRootRightBottom,
//     stemDownRootLeftTop: _halfStemDownRootLeftTop,
//   ),
//   black(
//     _blackGlyph,
//     _blackBbox,
//     hasStem: true,
//     stemUpRootRightBottom: _blackStemUpRootRightBottom,
//     stemDownRootLeftTop: _blackStemDownRootLeftTop,
//   );

//   const NoteHeadType(
//     this.glyph,
//     this.glyphBbox, {
//     required this.hasStem,
//     this.stemUpRootRightBottom,
//     this.stemDownRootLeftTop,
//   });
//   final String glyph;
//   final Offset? stemDownRootLeftTop;
//   final Offset? stemUpRootRightBottom;
//   final Rect glyphBbox;
//   final bool hasStem;

//   // factory NoteHeadType.fromNumber(String str) {
//   //   NoteParser.validate(str);
//   //   if (str.contains('1')) {
//   //     whole;
//   //   }
//   //   if (!str.contains('2')) {
//   //     half;
//   //   }
//   //   return black;
//   // }
//   double get width => glyphBbox.width;

//   static const _wholeBbox = Rect.fromLTRB(0, -0.544, 1.836, 0.548);
//   static const _halfBbox = Rect.fromLTRB(0, -0.5, 1.18, 0.5);
//   static const _blackBbox = Rect.fromLTRB(0, -0.5, 1.18, 0.5);

//   static const _wholeGlyph = '';
//   static const _halfGlyph = '';
//   static const _blackGlyph = '';

//   static const _halfStemUpRootRightBottom = Offset(1.18, -0.168);
//   static const _halfStemDownRootLeftTop = Offset(0, 0.168);

//   static const _blackStemUpRootRightBottom = Offset(1.18, -0.168);
//   static const _blackStemDownRootLeftTop = Offset(0, 0.168);
// }
