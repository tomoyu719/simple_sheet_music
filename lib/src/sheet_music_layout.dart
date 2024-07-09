import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/sheet_music_metrics.dart';
import 'package:simple_sheet_music/src/staff/staff_renderer.dart';

/// Represents the layout of the sheet music.
class SheetMusicLayout {
  SheetMusicLayout(
    this.metrics,
    this.lineColor, {
    required this.widgetHeight,
    required this.widgetWidth,
  });

  /// The height of the widget.
  final double widgetHeight;

  /// The width of the widget.
  final double widgetWidth;

  /// The metrics for the sheet music.
  final SheetMusicMetrics metrics;

  /// The color of the lines in the sheet music.
  final Color lineColor;

  /// The maximum width of a staff.
  double get _maximumStaffWidth => metrics.maximumStaffWidth;

  /// The sum of the horizontal margins of all the staffs.
  double get _maximumStaffHorizontalMarginSum =>
      metrics.maximumStaffHorizontalMarginSum;

  /// The horizontal padding of the sheet music.
  double get _horizontalPadding =>
      widgetWidth -
      (_maximumStaffWidth * canvasScale + _maximumStaffHorizontalMarginSum);

  /// The horizontal padding on the canvas.
  double get _horizontalPaddingOnCanvas => _horizontalPadding / canvasScale;

  /// The left padding on the canvas.
  double get _leftPaddingOnCanvas => _horizontalPaddingOnCanvas / 2;

  /// The vertical padding of the sheet music.
  double get _verticalPadding => widgetHeight - _staffsHeightsSum * canvasScale;

  /// The vertical padding on the canvas.
  double get _verticalPaddingOnCanvas => _verticalPadding / canvasScale;

  /// The upper padding on the canvas.
  double get _upperPaddingOnCanvas => _verticalPaddingOnCanvas / 2;

  /// The list of staff renderers.
  List<StaffRenderer> get staffRenderers {
    var currentY = _upperPaddingOnCanvas;
    return metrics.staffsMetricses.map((staffMetrics) {
      currentY += staffMetrics.upperHeight;
      final staffRenderer = staffMetrics.renderer(
        this,
        staffLineCenterY: currentY,
        leftPadding: _leftPaddingOnCanvas,
      );
      currentY += staffMetrics.lowerHeight;
      return staffRenderer;
    }).toList();
  }

  /// The sum of the heights of all the staffs.
  double get _staffsHeightsSum => metrics.staffsHeightSum;

  /// The scale factor for the width of the sheet music.
  double get _widthScale =>
      (widgetWidth - _maximumStaffHorizontalMarginSum) / _maximumStaffWidth;

  /// The scale factor for the height of the sheet music.
  double get _heightScale => widgetHeight / _staffsHeightsSum;

  /// The scale factor for the canvas.
  double get canvasScale => min(_widthScale, _heightScale);

  /// Renders the sheet music on the canvas.
  void render(Canvas canvas, Size size) {
    for (final staff in staffRenderers) {
      staff.render(canvas, size);
    }
  }
}
