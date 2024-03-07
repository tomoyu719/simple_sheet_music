// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:simple_sheet_music/src/draw_line_mixin.dart';
// import 'package:simple_sheet_music/src/music_objects/glyphs/clef/clef.dart';
// import 'package:simple_sheet_music/src/position_mixin.dart';
// import '../../music_object.dart';
// import '../../text_paint_mixin.dart';

// enum KeySignatureType {
//   sharp,
//   flat;
// }

// class KeySignature with TextPaint implements SimpleMusicObject {
//   final List<KeySignaturePart> keySignatureParts;
//   KeySignature.none() : keySignatureParts = <KeySignaturePart>[];
//   KeySignature.oneSharp(Clef clef)
//       : keySignatureParts =
//             getKeySignatureParts(clef, 1, KeySignatureType.sharp);
//   KeySignature.twoSharp(Clef clef)
//       : keySignatureParts =
//             getKeySignatureParts(clef, 2, KeySignatureType.sharp);
//   KeySignature.threeSharp(Clef clef)
//       : keySignatureParts =
//             getKeySignatureParts(clef, 3, KeySignatureType.sharp);
//   KeySignature.fourSharp(Clef clef)
//       : keySignatureParts =
//             getKeySignatureParts(clef, 4, KeySignatureType.sharp);
//   KeySignature.fiveSharp(Clef clef)
//       : keySignatureParts =
//             getKeySignatureParts(clef, 5, KeySignatureType.sharp);
//   KeySignature.sixSharp(Clef clef)
//       : keySignatureParts =
//             getKeySignatureParts(clef, 6, KeySignatureType.sharp);
//   KeySignature.sevenSharp(Clef clef)
//       : keySignatureParts =
//             getKeySignatureParts(clef, 7, KeySignatureType.sharp);

//   KeySignature.oneFlat(Clef clef)
//       : keySignatureParts =
//             getKeySignatureParts(clef, 1, KeySignatureType.flat);
//   KeySignature.twoFlat(Clef clef)
//       : keySignatureParts =
//             getKeySignatureParts(clef, 2, KeySignatureType.flat);
//   KeySignature.threeFlat(Clef clef)
//       : keySignatureParts =
//             getKeySignatureParts(clef, 3, KeySignatureType.flat);
//   KeySignature.fourFlat(Clef clef)
//       : keySignatureParts =
//             getKeySignatureParts(clef, 4, KeySignatureType.flat);
//   KeySignature.fiveFlat(Clef clef)
//       : keySignatureParts =
//             getKeySignatureParts(clef, 5, KeySignatureType.flat);
//   KeySignature.sixFlat(Clef clef)
//       : keySignatureParts =
//             getKeySignatureParts(clef, 6, KeySignatureType.flat);
//   KeySignature.sevenFlat(Clef clef)
//       : keySignatureParts =
//             getKeySignatureParts(clef, 7, KeySignatureType.flat);

//   static List<KeySignaturePart> getKeySignatureParts(
//       Clef clef, int partsNum, KeySignatureType keySignatureType) {
//     if (keySignatureType == KeySignatureType.sharp) {
//       final keySignaturePositions =
//           clef.sharpKeySignaturePartPositions.sublist(0, partsNum);
//       final keySignatureParts =
//           keySignaturePositions.map((e) => KeySignaturePart.sharp(e)).toList();
//       return keySignatureParts;
//     }
//     if (keySignatureType == KeySignatureType.flat) {
//       final keySignaturePositions =
//           clef.flatKeySignaturePartPositions.sublist(0, partsNum);
//       final keySignatureParts =
//           keySignaturePositions.map((e) => KeySignaturePart.flat(e)).toList();
//       return keySignatureParts;
//     }
//     throw 'Invalid keySignatureType: $keySignatureType';
//   }

//   @override
//   EdgeInsets get margin => EdgeInsets.zero;

//   @override
//   Rect get bbox => keySignatureParts.isEmpty
//       ? Rect.zero
//       : Rect.fromLTRB(0.0, upperY, keySignaturePartsWidthSum, lowerY);

//   double get keySignaturePartsWidthSum => keySignatureParts
//       .map((e) => e.width)
//       .reduce((value, element) => value + element);

//   double get upperY => keySignatureParts.map((e) => e.upperY).reduce(max);

//   double get lowerY => keySignatureParts.map((e) => e.lowerY).reduce(min);

//   @override
//   void render(Canvas canvas, Size size, Offset offset, double scale) {
//     double currentKeyPartX = 0.0;
//     for (final part in keySignatureParts) {
//       part.render(canvas, size, offset + Offset(currentKeyPartX, 0), scale);
//       currentKeyPartX += part.width;
//     }
//   }
// }

// class KeySignaturePart with TextPaint, HasPosition, LineDrawer {
//   static const _sharpGlyph = '';
//   static const _flatGlyph = '';
//   static const _sharpBbox = Rect.fromLTRB(0.0, 1.4, 0.996, -1.392);
//   static const _flatBbox = Rect.fromLTRB(0.0, 1.756, 0.904, -0.7);

//   final String glyph;
//   final int position;
//   final Rect glyphBbox;

//   KeySignaturePart.sharp(this.position)
//       : glyph = _sharpGlyph,
//         glyphBbox = _sharpBbox;

//   KeySignaturePart.flat(this.position)
//       : glyph = _flatGlyph,
//         glyphBbox = _flatBbox;

//   double get leftX => glyphBbox.left;
//   double get width => glyphBbox.width;
//   double get upperY => glyphBbox.top + positionOffsetHeight(position);
//   double get lowerY => glyphBbox.bottom + positionOffsetHeight(position);
//   Offset get positonOffset => positionOffset(position);

//   void render(Canvas canvas, Size size, Offset offset, double scale) {
//     textPaint(canvas, size, glyph, offset + positonOffset);
//   }

//   @override
//   String toString() {
//     return 'KeySignaturePart(glyph: $glyph, bbox: $glyphBbox, width: $width, upperY: $upperY, lowerY: $lowerY)';
//   }
// }
