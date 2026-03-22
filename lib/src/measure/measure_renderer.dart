import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/constants.dart';
import 'package:simple_sheet_music/src/measure/bar_line_type.dart';
import 'package:simple_sheet_music/src/measure/measure_metrics.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

/// The renderer for a measure in sheet music.
class MeasureRenderer {
  const MeasureRenderer(
    this.symbolRenderers,
    this.measureMetrics,
    this.layout, {
    required this.measureOriginX,
    required this.staffLineCenterY,
    this.barLine = BarLineType.single,
  });

  final List<MusicalSymbolRenderer> symbolRenderers;
  final MeasureMetrics measureMetrics;
  final double measureOriginX;
  final double staffLineCenterY;
  final BarLineType barLine;

  /// Performs a hit test at the given [position] and returns the corresponding [MusicalSymbolRenderer].
  ///
  /// Returns `null` if no symbol is hit.
  MusicalSymbolRenderer? hitTest(Offset position) {
    for (final object in symbolRenderers) {
      if (object.isHit(position)) {
        return object;
      }
    }
    return null;
  }

  /// Renders the measure on the given [canvas] with the specified [size].
  void render(Canvas canvas, Size size) {
    _renderStaffLine(canvas);
    for (final symbol in symbolRenderers) {
      symbol.render(canvas);
    }
    _renderBarLine(canvas);
  }

  void _renderStaffLine(Canvas canvas) {
    final initX = measureOriginX;
    final staffLineHeights = [
      staffLineCenterY - Constants.staffSpace * 2,
      staffLineCenterY - Constants.staffSpace,
      staffLineCenterY,
      staffLineCenterY + Constants.staffSpace,
      staffLineCenterY + Constants.staffSpace * 2,
    ];
    for (final height in staffLineHeights) {
      canvas.drawLine(
        Offset(initX, height),
        Offset(initX + width, height),
        Paint()
          ..color = layout.lineColor
          ..strokeWidth = measureMetrics.staffLineThickness,
      );
    }
  }

  void _renderBarLine(Canvas canvas) {
    if (barLine == BarLineType.none) return;

    final top    = staffLineCenterY - Constants.staffSpace * 2;
    final bottom = staffLineCenterY + Constants.staffSpace * 2;
    final x      = measureOriginX + width;
    final thick  = measureMetrics.staffLineThickness;

    final thinPaint = Paint()
      ..color = layout.lineColor
      ..strokeWidth = thick;

    final thickPaint = Paint()
      ..color = layout.lineColor
      ..strokeWidth = thick * 4;

    switch (barLine) {
      case BarLineType.none:
        break;
      case BarLineType.single:
        canvas.drawLine(Offset(x, top), Offset(x, bottom), thinPaint);
        break;
      case BarLineType.double_:
        final gap = Constants.staffSpace * 0.18;
        canvas.drawLine(Offset(x - gap, top), Offset(x - gap, bottom), thinPaint);
        canvas.drawLine(Offset(x, top), Offset(x, bottom), thinPaint);
        break;
      case BarLineType.final_:
        final gap = Constants.staffSpace * 0.25;
        canvas.drawLine(Offset(x - gap - thick * 2, top), Offset(x - gap - thick * 2, bottom), thinPaint);
        canvas.drawLine(Offset(x, top), Offset(x, bottom), thickPaint);
        break;
    }
  }

  final SheetMusicLayout layout;

  /// The width of the measure.
  double get width =>
      measureMetrics.objectsWidth + measureMetrics.horizontalMarginSum / scale;

  /// The scale of the measure.
  double get scale => layout.canvasScale;
}
