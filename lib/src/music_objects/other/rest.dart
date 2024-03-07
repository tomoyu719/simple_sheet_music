// import 'dart:ui';

// import 'package:flutter/material.dart';
// import '../../music_object.dart';
// import '../../text_paint_mixin.dart';

// class Rest with TextPaint implements SimpleMusicObject {
//   static const restWholeGlyph = '';
//   static const restHalfGlyph = '';
//   static const restQuarterGlyph = '𝄽';
//   static const rest8thGlyph = '𝄾';
//   static const rest16thGlyph = '𝄿';
//   static const rest32ndGlyph = '𝅀';
//   static const rest64thGlyph = '𝅁';
//   static const rest128thGlyph = '𝅂';

//   static const restWholeGlyphBboxRatio =
//       Rect.fromLTRB(0.0, 0.036, 1.128, -0.54);
//   static const restHalfGlyphBboxRatio =
//       Rect.fromLTRB(0.0, 0.568, 1.128, -0.008);
//   static const restQuarterGlyphBboxRatio =
//       Rect.fromLTRB(0.004, 1.492, 1.08, -1.5);
//   static const rest8thGlyphBboxRatio = Rect.fromLTRB(0.0, 0.696, 0.988, -1.004);
//   static const rest16thGlyphBboxRatio = Rect.fromLTRB(0.0, 0.716, 1.28, -2.0);
//   static const rest32ndGlyphBboxRatio = Rect.fromLTRB(0.0, 1.704, 1.452, -2.0);
//   static const rest64thGlyphBboxRatio = Rect.fromLTRB(0.0, 1.72, 1.692, -3.012);
//   static const rest128thGlyphBboxRatio = Rect.fromLTRB(0.0, 2.756, 1.94, -3.0);

//   final Color color;
//   final EdgeInsets margin;
//   final String glyph;
//   @override
//   final Rect bbox;

//   const Rest.restWhole({
//     this.color = Colors.black,
//     this.margin = EdgeInsets.zero,
//   })  : glyph = restWholeGlyph,
//         bbox = restWholeGlyphBboxRatio;
//   const Rest.restHalf({
//     this.color = Colors.black,
//     this.margin = EdgeInsets.zero,
//   })  : glyph = restHalfGlyph,
//         bbox = restHalfGlyphBboxRatio;
//   const Rest.restQuarter({
//     this.color = Colors.black,
//     this.margin = EdgeInsets.zero,
//   })  : glyph = restQuarterGlyph,
//         bbox = restQuarterGlyphBboxRatio;
//   const Rest.rest8th({
//     this.color = Colors.black,
//     this.margin = EdgeInsets.zero,
//   })  : glyph = rest8thGlyph,
//         bbox = rest8thGlyphBboxRatio;
//   const Rest.rest16th({
//     this.color = Colors.black,
//     this.margin = EdgeInsets.zero,
//   })  : glyph = rest16thGlyph,
//         bbox = rest16thGlyphBboxRatio;
//   const Rest.rest32nd({
//     this.color = Colors.black,
//     this.margin = EdgeInsets.zero,
//   })  : glyph = rest32ndGlyph,
//         bbox = rest32ndGlyphBboxRatio;
//   const Rest.rest64th({
//     this.color = Colors.black,
//     this.margin = EdgeInsets.zero,
//   })  : glyph = rest64thGlyph,
//         bbox = rest64thGlyphBboxRatio;
//   const Rest.rest128th({
//     this.color = Colors.black,
//     this.margin = EdgeInsets.zero,
//   })  : glyph = rest128thGlyph,
//         bbox = rest128thGlyphBboxRatio;

//   @override
//   void render(Canvas canvas, Size size, Offset offset, double scale) {
//     textPaint(canvas, size, glyph, offset, color);
//   }

//   @override
//   void setOnY0() {
//     // TODO: implement setOnY0
//   }
// }

// // const restWholeGlyphHeight = (1.128 - 0.0) * fontSize;
// // const restHalfGlyphHeight = (1.128 - 0.0) * fontSize;
// // const restQuarterGlyphHeight = (1.08 - 0.004) * fontSize;
// // const rest8thGlyphHeight = (0.988 - 0.0) * fontSize;
// // const rest16thGlyphHeight = (1.28 - 0.0) * fontSize;
// // const rest32ndGlyphHeight = (1.452 - 0.0) * fontSize;
// // const rest64thGlyphHeight = (1.692 - 0.0) * fontSize;
// // const rest128thGlyphHeight = (1.94 - 0.0) * fontSize;

// // const restWholeGlyph = '𝄻';
// // const restHalfGlyph = '𝄼';
// // const restQuarterGlyph = '𝄽';
// // const rest8thGlyph = '𝄾';
// // const rest16thGlyph = '𝄿';
// // const rest32ndGlyph = '𝅀';
// // const rest64thGlyph = '𝅁';
// // const rest128thGlyph = '𝅂';

// // const restsOffsetToY0 = Offset(0, -1.762 * fontSize - staffLineSpaceHeight);
// // const restsOffsetToY0 = Offset(0, 0);

// // enum Rest with TextPaint, LineDrawer implements MusicObject {
// //   whole(restWholeGlyphWidth, restWholeGlyphHeight, restWholeGlyph,
// //       restsOffsetToY0),
// //   half(restHalfGlyphWidth, restHalfGlyphHeight, restHalfGlyph, restsOffsetToY0),
// //   quarter(restQuarterGlyphWidth, restQuarterGlyphHeight, restQuarterGlyph,
// //       restsOffsetToY0),
// //   rest_8th(
// //       rest8thGlyphWidth, rest8thGlyphHeight, rest8thGlyph, restsOffsetToY0),
// //   rest_16th(
// //       rest16thGlyphWidth, rest16thGlyphHeight, rest16thGlyph, restsOffsetToY0),
// //   rest_32nd(
// //       rest32ndGlyphWidth, rest32ndGlyphHeight, rest32ndGlyph, restsOffsetToY0),
// //   rest_64th(
// //       rest64thGlyphWidth, rest64thGlyphHeight, rest64thGlyph, restsOffsetToY0),
// //   rest_128th(rest128thGlyphWidth, rest128thGlyphHeight, rest128thGlyph,
// //       restsOffsetToY0);

// //   @override
// //   final double width;
// //   @override
// //   final double height;
// //   final String glyph;
// //   @override
// //   final Offset offsetToY0;
// //   // final double upperY;
// //   // final double lowerY;
// //   const Rest(this.width, this.height, this.glyph, this.offsetToY0);
// //   // const Rest(this.width, this.height, this.glyph, this.offsetToY0, this.upperY,
// //   //     this.lowerY);

// //   @override
// //   void setOnY0() {}

// //   @override
// //   void render(Canvas canvas, Size size, Offset offset) {
// //     // textPaint(canvas, size, glyph, offset + offsetToY0);

// //     // drawLine(canvas, Offset(0, 0.004 * fontSize),
// //     //     Offset(10000000, 0.004 * fontSize), 5.0);
// //     // drawLine(canvas, Offset(0, 1.08 * fontSize),
// //     //     Offset(10000000, 1.08 * fontSize), 5.0);
// //     textPaint(canvas, size, glyph, Offset(offset.dx, 0));
// //   }
// // }
