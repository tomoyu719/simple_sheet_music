// import 'dart:ui';

// import '../../../mixins/draw_line_mixin.dart';
// import '../note_parts.dart';

// class NoteStem with LineDrawer implements NoteParts {

//   const NoteStem(this.isStemUp,
//       {required this.stemRootOffset, required this.stemTipOffset,});
//   static const minStemLength = 3.5;
//   static const stemThickness = 0.12;

//   final Offset stemRootOffset;
//   final Offset stemTipOffset;

//   final bool isStemUp;

//   Rect get bbox {
//     final top = isStemUp ? stemTipOffset.dy : stemRootOffset.dy;
//     final bottom = isStemUp ? stemRootOffset.dy : stemTipOffset.dy;
//     final left = stemRootOffset.dx - stemThickness / 2;
//     final right = stemRootOffset.dx + stemThickness / 2;
//     return Rect.fromLTRB(left, top, right, bottom);
//   }

//   @override
//   double get upperHeight =>
//       isStemUp ? stemTipOffset.dy.abs() : stemRootOffset.dy.abs();

//   @override
//   double get lowerHeight =>
//       isStemUp ? stemRootOffset.dy.abs() : stemTipOffset.dy.abs();

//   render(Canvas canvas, Color color, Offset globalOffset) {
//     drawLine(canvas, globalOffset + stemTipOffset,
//         globalOffset + stemRootOffset, stemThickness, color,);
//   }
// }
