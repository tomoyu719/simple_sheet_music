import 'package:flutter/material.dart';

import '../measure/built_measure.dart';
import 'staff_on_canvas.dart';

/// Represents a staff that contains multiple measures.
class BuiltStaff {
  final List<BuiltMeasure> measures;
  final Color lineColor;
  final double width;
  final double upperHeight;
  final double lowerHeight;

  /// Constructs a [BuiltStaff] with the given [measures] and [lineColor].
  BuiltStaff(this.measures, this.lineColor,
      {required this.width,
      required this.upperHeight,
      required this.lowerHeight});

  /// Gets the total height of the staff.
  double get height => upperHeight + lowerHeight;

  /// Places the staff on the canvas at the specified [staffLineCenterY] and [sheetMusicMargin].
  StaffOnCanvas placeOnCanvas(
      double staffLineCenterY, EdgeInsets sheetMusicMargin) {
    double currentX = sheetMusicMargin.left;
    final measuresOnCanvas = measures.map((measure) {
      final measureOnCanvas = measure.placeOnCanvas(staffLineCenterY, currentX);
      currentX += measure.width;
      return measureOnCanvas;
    }).toList();
    final bbox = Rect.fromLTRB(
        sheetMusicMargin.left,
        staffLineCenterY - upperHeight,
        currentX,
        staffLineCenterY + lowerHeight);
    return StaffOnCanvas(measuresOnCanvas, bbox);
  }
}
