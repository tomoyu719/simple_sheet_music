import 'package:flutter/material.dart';

import '../measure/measure_on_canvas.dart';
import '../mixins/debug_paint_mixin.dart';
import '../music_objects/music_object_on_canvas.dart';

/// Represents a staff on a canvas.
///
/// A staff is a collection of measures that are rendered on a canvas.
/// It provides methods for hit testing and rendering.
class StaffOnCanvas with DebugPaint {
  final List<MeasureOnCanvas> measureOnCanvas;
  final Rect bbox;

  /// Constructs a [StaffOnCanvas] object with the given measures and bounding box.
  const StaffOnCanvas(this.measureOnCanvas, this.bbox);

  /// Performs a hit test at the given position on the staff.
  ///
  /// Returns the [ObjectOnCanvas] that was hit, or `null` if no object was hit.
  ObjectOnCanvas? hitTest(Offset position) {
    for (final measure in measureOnCanvas) {
      final hit = measure.hitTest(position);
      if (hit != null) {
        return hit;
      }
    }
    return null;
  }

  /// Renders the staff on the given canvas with the specified size and font family.
  void render(Canvas canvas, Size size, String fontFamily) {
    for (final measure in measureOnCanvas) {
      measure.render(canvas, size, fontFamily);
    }
  }
}
