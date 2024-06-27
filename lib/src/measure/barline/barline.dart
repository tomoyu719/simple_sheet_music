// import 'barline_renderer.dart';
// import 'renderer/barline_final_renderer.dart';
// import 'renderer/barline_thick_renderer.dart';
// import 'renderer/barline_thin_renderer.dart';

// enum Barline {
//   barlineThin(BarlineThinRenderer.thickness),
//   barlineThick(BarlineThickRenderer.thickness),
//   barlineFinal(BarlineThinRenderer.thickness +
//       BarlineFinalRenderer.separation +
//       BarlineThickRenderer.thickness,);

//   const Barline(this.width);

//   final double width;

//   BarlineRenderer renderer(color,
//       {required double measureEndX, required double staffLineCenterY,}) {
//     switch (this) {
//       case barlineThin:
//         return BarlineThinRenderer(
//             color: color,
//             barlineRightX: measureEndX,
//             staffLineCenterY: staffLineCenterY,);
//       case barlineThick:
//         return BarlineThickRenderer(
//             color: color,
//             barlineRightX: measureEndX,
//             staffLineCenterY: staffLineCenterY,);
//       case barlineFinal:
//         return BarlineFinalRenderer(
//             color: color,
//             barlineRightX: measureEndX,
//             staffLineCenterY: staffLineCenterY,);
//       default:
//         throw Exception('Invalid BarlineType');
//     }
//   }
// }
