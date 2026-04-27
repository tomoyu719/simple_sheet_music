import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/constants.dart';
import 'package:simple_sheet_music/src/extension/list_extension.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

/// The renderer for a measure in sheet music.
/// Combines metrics calculation and rendering functionality.
class MeasureRenderer {
  const MeasureRenderer(
    this.symbolRenderers,
    this.metadata, {
    required this.isNewLine,
  });

  /// The list of [MusicalSymbolRenderer] representing the renderers of each musical
  /// symbol in the measure.
  final List<MusicalSymbolRenderer> symbolRenderers;

  /// The [GlyphMetadata] object containing metadata for the measure.
  final GlyphMetadata metadata;

  /// Indicates whether a line break should occur in this measure.
  final bool isNewLine;

  // Metrics properties

  /// Gets the total width of all the musical symbols in the measure.
  double get objectsWidth => symbolRenderers.map((symbol) => symbol.width).sum;

  /// Gets the maximum upper height among all the musical symbols in the measure.
  double get _symbolMaximumUpperHeight =>
      symbolRenderers.map((symbol) => symbol.upperHeight).max;

  /// Returns the height of the upper part of the measure.
  double get _measureUpperHeight => metadata.measureUpperHeight;

  /// Returns the maximum height of the measure upper part.
  double get upperHeight => max(_symbolMaximumUpperHeight, _measureUpperHeight);

  /// Gets the maximum lower height among all the musical symbols in the measure.
  double get _symbolMaximumLowerHeight =>
      symbolRenderers.map((symbol) => symbol.lowerHeight).max;

  /// Returns the height of the lower part of the measure.
  double get _measureLowerHeight => metadata.measureLowerHeight;

  /// Returns the maximum height of the measure lower part.
  double get lowerHeight => max(_symbolMaximumLowerHeight, _measureLowerHeight);

  /// Gets the sum of the horizontal margins of all the musical symbols in the measure.
  double get horizontalMarginSum =>
      symbolRenderers.map((symbol) => symbol.margin.horizontal).sum;

  /// Gets the thickness of the staff lines in the measure.
  double get staffLineThickness => metadata.staffLineThickness;

  // Rendering methods

  /// Performs a hit test at the given [position] and returns the corresponding [MusicalSymbolRenderer].
  ///
  /// Returns `null` if no symbol is hit.
  MusicalSymbolRenderer? hitTest(
    Offset position, {
    required SheetMusicLayout layout,
    required double measureInitialX,
    required double staffLineCenterY,
  }) {
    var x = measureInitialX;
    for (final symbol in symbolRenderers) {
      if (symbol.isHit(
        position,
        layout: layout,
        staffLineCenterY: staffLineCenterY,
        symbolX: x,
      )) {
        return symbol;
      }
      x += symbol.width + symbol.margin.horizontal / layout.canvasScale;
    }
    return null;
  }

  /// Renders the measure on the given [canvas] with the specified [size].
  void render(
    Canvas canvas,
    Size size, {
    required SheetMusicLayout layout,
    required double measureInitialX,
    required double staffLineCenterY,
  }) {
    _renderStaffLine(canvas, layout, measureInitialX, staffLineCenterY);
    var x = measureInitialX;
    for (final symbol in symbolRenderers) {
      symbol.render(
        canvas,
        layout: layout,
        staffLineCenterY: staffLineCenterY,
        symbolX: x,
      );
      x += symbol.width + symbol.margin.horizontal / layout.canvasScale;
    }
  }

  void _renderStaffLine(
    Canvas canvas,
    SheetMusicLayout layout,
    double measureInitialX,
    double staffLineCenterY,
  ) {
    final initX = measureInitialX;
    final measureWidth =
        objectsWidth + horizontalMarginSum / layout.canvasScale;
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
        Offset(initX + measureWidth, height),
        Paint()
          ..color = layout.lineColor
          ..strokeWidth = staffLineThickness,
      );
    }
  }

  /// The width of the measure for a given scale.
  double width(double scale) => objectsWidth + horizontalMarginSum / scale;
}
