// import 'package:flutter/material.dart';

// /// A mixin that provides methods for painting debug visuals on a canvas.
// mixin DebugPaint {
//   /// Paints a rectangular box on the canvas.
//   ///
//   /// The [canvas] is the canvas on which to paint.
//   /// The [size] is the size of the canvas.
//   /// The [box] is the rectangular box to be painted.
//   /// The [color] is the color of the box (default is red).
//   /// The [thickness] is the thickness of the box's outline (default is 0.01).
//   void boxPaint(Canvas canvas, Size size, Rect box,
//       {color = Colors.red, thickness = 0.01,}) {
//     final paint = Paint()
//       ..color = color
//       ..strokeWidth = thickness
//       ..style = PaintingStyle.stroke;
//     canvas.drawRect(box, paint);
//   }

//   /// Paints a circle on the canvas.
//   ///
//   /// The [canvas] is the canvas on which to paint.
//   /// The [offset] is the center of the circle.
//   /// The [radius] is the radius of the circle (default is 0.1).
//   /// The [color] is the color of the circle (default is red).
//   void circlePaint(Canvas canvas, Offset offset,
//       {double radius = 0.1, Color color = Colors.red,}) {
//     final paint = Paint()..color = color;
//     canvas.drawCircle(offset, radius, paint);
//   }
// }
