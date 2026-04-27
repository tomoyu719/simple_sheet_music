import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/extension/list_extension.dart';
import 'package:simple_sheet_music/src/measure/measure_renderer.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

/// The renderer for a staff, which is responsible for rendering measures,
/// handling hit tests, and providing metrics.
class StaffRenderer {
  const StaffRenderer(this.measureRenderers);

  final List<MeasureRenderer> measureRenderers;

  // Metrics properties

  /// The height of the upper part of the staff.
  double get upperHeight =>
      measureRenderers.map((measure) => measure.upperHeight).max;

  /// The height of the lower part of the staff.
  double get lowerHeight =>
      measureRenderers.map((measure) => measure.lowerHeight).max;

  /// The total width of the staff, including the width of its objects and margins.
  double get width => _objectsWidth + horizontalMarginSum;

  /// The total width of the objects in the staff.
  double get _objectsWidth =>
      measureRenderers.map((measure) => measure.objectsWidth).sum;

  /// The sum of the horizontal margins between measures in the staff.
  double get horizontalMarginSum =>
      measureRenderers.map((measure) => measure.horizontalMarginSum).sum;

  /// The total height of the staff.
  double get height => upperHeight + lowerHeight;

  // Rendering methods

  /// Performs a hit test at the given position on the staff.
  ///
  /// Returns the [MusicalSymbolRenderer] that was hit, or `null` if no object was hit.
  MusicalSymbolRenderer? hitTest(
    Offset position, {
    required SheetMusicLayout layout,
    required double staffLineCenterY,
    required double leftPadding,
  }) {
    var currentX = leftPadding;
    for (final measure in measureRenderers) {
      final hit = measure.hitTest(
        position,
        layout: layout,
        measureInitialX: currentX,
        staffLineCenterY: staffLineCenterY,
      );
      if (hit != null) {
        return hit;
      }
      currentX += measure.width(layout.canvasScale);
    }
    return null;
  }

  /// Renders the staff on the given canvas with the specified size.
  void render(
    Canvas canvas,
    Size size, {
    required SheetMusicLayout layout,
    required double staffLineCenterY,
    required double leftPadding,
  }) {
    var currentX = leftPadding;
    for (final measure in measureRenderers) {
      measure.render(
        canvas,
        size,
        layout: layout,
        measureInitialX: currentX,
        staffLineCenterY: staffLineCenterY,
      );
      currentX += measure.width(layout.canvasScale);
    }
  }
}
