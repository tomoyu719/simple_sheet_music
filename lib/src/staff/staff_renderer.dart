import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/extension/list_extension.dart';
import 'package:simple_sheet_music/src/measure/measure_renderer.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';
import 'package:simple_sheet_music/src/staff/staff.dart';

/// The renderer for a staff, which is responsible for rendering measures,
/// handling hit tests, and providing metrics.
class StaffRenderer implements MusicalSymbolRenderer {
  const StaffRenderer(this.measureRenderers, {this.staff});

  final List<MeasureRenderer> measureRenderers;

  /// The staff associated with this renderer (optional for backward compatibility).
  final Staff? staff;

  // Metrics properties

  /// The height of the upper part of the staff.
  @override
  double get upperHeight =>
      measureRenderers.map((measure) => measure.upperHeight).max;

  /// The height of the lower part of the staff.
  @override
  double get lowerHeight =>
      measureRenderers.map((measure) => measure.lowerHeight).max;

  /// The total width of the staff, including the width of its objects and margins.
  @override
  double get width => _objectsWidth + horizontalMarginSum;

  /// The total width of the objects in the staff.
  double get _objectsWidth =>
      measureRenderers.map((measure) => measure.objectsWidth).sum;

  /// The sum of the horizontal margins between measures in the staff.
  double get horizontalMarginSum =>
      measureRenderers.map((measure) => measure.horizontalMarginSum).sum;

  /// The total height of the staff.
  double get height => upperHeight + lowerHeight;

  @override
  EdgeInsets get margin => staff?.margin ?? EdgeInsets.zero;

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
      currentX += measure.widthWithScale(layout.canvasScale);
    }
    return null;
  }

  @override
  bool isHit(
    Offset position, {
    required SheetMusicLayout layout,
    required double staffLineCenterY,
    required double symbolX,
  }) {
    return hitTest(
      position,
      layout: layout,
      staffLineCenterY: staffLineCenterY,
      leftPadding: symbolX,
    ) != null;
  }

  @override
  void render(
    Canvas canvas, {
    required SheetMusicLayout layout,
    required double staffLineCenterY,
    required double symbolX,
  }) {
    var currentX = symbolX;
    for (final measure in measureRenderers) {
      measure.render(
        canvas,
        layout: layout,
        staffLineCenterY: staffLineCenterY,
        symbolX: currentX,
      );
      currentX += measure.widthWithScale(layout.canvasScale);
    }
  }

  /// Renders the staff on the given canvas with the specified size.
  void renderWithSize(
    Canvas canvas,
    Size size, {
    required SheetMusicLayout layout,
    required double staffLineCenterY,
    required double leftPadding,
  }) {
    render(
      canvas,
      layout: layout,
      staffLineCenterY: staffLineCenterY,
      symbolX: leftPadding,
    );
  }
}
