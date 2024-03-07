import 'dart:ui';

import '../mixins/draw_line_mixin.dart';

/// A class that renders staff lines on a canvas.
///
/// The [StaffLineRenderer] class is responsible for drawing staff lines on a canvas.
/// It takes in parameters such as the center Y position of the staff lines, the initial X position,
/// the width of the lines, and the color of the lines.
class StaffLineRenderer with LineDrawer {
  // Constants for staff line thickness and spacing
  static const staffLineThickness = 0.13;
  static const staffLineSpaceHeight = 1.0;

  // Constants for calculating upper and lower staff line heights
  static const upperToCenterHeight =
      staffLineSpaceHeight * 2 + staffLineThickness / 2;
  static const lowerToCenterHeight =
      staffLineSpaceHeight * 2 + staffLineThickness / 2;

  final double staffLineCenterY;
  final double staffLineInitialX;
  final double width;
  final Color lineColor;

  /// Constructs a [StaffLineRenderer] with the given parameters.
  ///
  /// The [lineColor] parameter specifies the color of the staff lines.
  /// The [staffLineCenterY] parameter specifies the Y position of the center of the staff lines.
  /// The [staffLineInitialX] parameter specifies the initial X position of the staff lines.
  /// The [width] parameter specifies the width of the staff lines.
  const StaffLineRenderer(this.lineColor,
      {required this.staffLineCenterY,
      required this.staffLineInitialX,
      required this.width});

  /// Generates the Y positions of the staff lines.
  List<double> get _staffLineYs => staffLineYs(staffLineCenterY);

  /// Renders the staff lines on the given [canvas].
  void render(Canvas canvas) {
    for (final y in _staffLineYs) {
      final p1 = Offset(staffLineInitialX, y);
      final p2 = Offset(staffLineInitialX + width, y);
      drawLine(canvas, p1, p2, staffLineThickness, lineColor);
    }
  }
}

/// Generates the Y positions of the staff lines.
List<double> staffLineYs(double staffLineCenterY) => List.generate(
    5,
    (index) =>
        staffLineCenterY +
        (index - 2) * StaffLineRenderer.staffLineSpaceHeight);
