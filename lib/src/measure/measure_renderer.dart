import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/constants.dart';
import 'package:simple_sheet_music/src/extension/list_extension.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';

/// The renderer for a measure in sheet music.
/// Combines metrics calculation and rendering functionality.
class MeasureRenderer {
  MeasureRenderer(
    this.symbolRenderers,
    this.metadata, {
    required this.isNewLine,
    required this.lineColor,
  });

  /// The list of [MusicalSymbolRenderer] representing the renderers of each musical
  /// symbol in the measure.
  final List<MusicalSymbolRenderer> symbolRenderers;

  /// The [GlyphMetadata] object containing metadata for the measure.
  final GlyphMetadata metadata;

  /// Indicates whether a line break should occur in this measure.
  final bool isNewLine;

  /// The color of the staff lines.
  final Color lineColor;

  // Position state
  double _canvasScale = 1;
  double _measureInitialX = 0;
  double _staffLineCenterY = 0;

  /// Sets the position information for rendering.
  void setPosition({
    required double canvasScale,
    required double measureInitialX,
    required double staffLineCenterY,
  }) {
    _canvasScale = canvasScale;
    _measureInitialX = measureInitialX;
    _staffLineCenterY = staffLineCenterY;

    // Set positions for all symbols
    var x = measureInitialX;
    for (final symbol in symbolRenderers) {
      symbol.setPosition(
        canvasScale: canvasScale,
        staffLineCenterY: staffLineCenterY,
        symbolX: x,
      );
      x += symbol.width + symbol.margin.horizontal / canvasScale;
    }
  }

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
  /// [setPosition] must be called before this method.
  MusicalSymbolRenderer? hitTest(Offset position) {
    for (final symbol in symbolRenderers) {
      if (symbol.isHit(position)) {
        return symbol;
      }
    }
    return null;
  }

  /// Renders the measure on the given [canvas] with the specified [size].
  ///
  /// [setPosition] must be called before this method.
  void render(Canvas canvas, Size size) {
    _renderStaffLine(canvas);
    for (final symbol in symbolRenderers) {
      symbol.render(canvas);
    }
  }

  void _renderStaffLine(Canvas canvas) {
    final initX = _measureInitialX;
    final measureWidth = objectsWidth + horizontalMarginSum / _canvasScale;
    final staffLineHeights = [
      _staffLineCenterY - Constants.staffSpace * 2,
      _staffLineCenterY - Constants.staffSpace,
      _staffLineCenterY,
      _staffLineCenterY + Constants.staffSpace,
      _staffLineCenterY + Constants.staffSpace * 2,
    ];
    for (final height in staffLineHeights) {
      canvas.drawLine(
        Offset(initX, height),
        Offset(initX + measureWidth, height),
        Paint()
          ..color = lineColor
          ..strokeWidth = staffLineThickness,
      );
    }
  }

  /// The width of the measure for a given scale.
  double width(double scale) => objectsWidth + horizontalMarginSum / scale;
}
