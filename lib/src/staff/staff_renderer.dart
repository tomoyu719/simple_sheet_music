import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/measure/measure_on_y0.dart';

import '../measure/measure_renderer.dart';
import '../music_objects/interface/musical_symbol_renderer.dart';

class StaffRenderer {
  StaffRenderer(List<MeasureOnY0> measures,
      {required double staffLineCenterY, required double leftPadding,}) {
    var currentX = leftPadding;
    final renderers = <MeasureRenderer>[];
    for (final measure in measures) {
      final m = measure.renderer(
          measureOriginX: currentX, staffLineCenterY: staffLineCenterY,);
      currentX += measure.width;
      renderers.add(m);
    }
    measureRenderer = renderers;
  }

  late final List<MeasureRenderer> measureRenderer;

  /// Performs a hit test at the given position on the staff.
  ///
  /// Returns the [MusicalSymbolRenderer] that was hit, or `null` if no object was hit.
  MusicalSymbolRenderer? hitTest(Offset position) {
    for (final measure in measureRenderer) {
      final hit = measure.hitTest(position);
      if (hit != null) {
        return hit;
      }
    }
    return null;
  }

  /// Renders the staff on the given canvas with the specified size and font family.
  void render(Canvas canvas, Size size) {
    for (final measure in measureRenderer) {
      measure.render(canvas, size);
    }
  }

  // void setOffset(double currentY, double leftPadding) {
  //   var currentX = leftPadding;
  //   for (final measure in measureRenderer) {
  //     measure.setOffset(currentX, currentY);
  //     currentX += measure.width;
  //   }
  // }
}
// /// Represents a staff on a canvas.
// ///
// /// A staff is a collection of measures that are rendered on a canvas.
// /// It provides methods for hit testing and rendering.
// class StaffOnCanvas with DebugPaint {
//   final List<MeasureOnCanvas> measureOnCanvas;
//   final Rect bbox;

//   /// Constructs a [StaffOnCanvas] object with the given measures and bounding box.
//   const StaffOnCanvas(this.measureOnCanvas, this.bbox);

//   /// Performs a hit test at the given position on the staff.
//   ///
//   /// Returns the [MusicalObjectRenderer] that was hit, or `null` if no object was hit.
//   MusicalObjectRenderer? hitTest(Offset position) {
//     for (final measure in measureOnCanvas) {
//       final hit = measure.hitTest(position);
//       if (hit != null) {
//         return hit;
//       }
//     }
//     return null;
//   }

//   /// Renders the staff on the given canvas with the specified size and font family.
//   void render(Canvas canvas, Size size, String fontFamily) {
//     for (final measure in measureOnCanvas) {
//       measure.render(canvas, size, fontFamily);
//     }
//   }
// }
