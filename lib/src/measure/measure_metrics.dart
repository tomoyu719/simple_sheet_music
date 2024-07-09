import 'dart:math';

import 'package:simple_sheet_music/src/extension/list_extension.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/measure/measure_renderer.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_metrics.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

/// Represents the metrics of a measure in sheet music.
class MeasureMetrics {
  /// The [musicalSymbolsMetricses] parameter is a list of [MusicalSymbolMetrics]
  /// representing the metrics of each musical symbol in the measure.
  ///
  /// The [metadata] parameter is a [GlyphMetadata] object containing metadata
  /// for the measure.
  ///
  /// The [isNewLine] parameter indicates whether a line break should occur in this measure.
  const MeasureMetrics(
    this.musicalSymbolsMetricses,
    this.metadata, {
    required this.isNewLine,
  });

  /// The list of [MusicalSymbolMetrics] representing the metrics of each musical
  /// symbol in the measure.
  final List<MusicalSymbolMetrics> musicalSymbolsMetricses;

  /// The [GlyphMetadata] object containing metadata for the measure.
  final GlyphMetadata metadata;

  /// Indicates whether a line break should occur in this measure.
  final bool isNewLine;

  /// Gets the total width of all the musical symbols in the measure.
  double get objectsWidth =>
      musicalSymbolsMetricses.map((symbol) => symbol.width).sum;

  /// Gets the maximum upper height among all the musical symbols in the measure.
  double get _symbolMaximumUpperHeight =>
      musicalSymbolsMetricses.map((symbol) => symbol.upperHeight).max;

  /// Returns the height of the upper part of the measure.
  double get _measureUpperHeight => metadata.measureUpperHeight;

  /// Returns the maximum height of the measure upper part.
  double get upperHeight => max(_symbolMaximumUpperHeight, _measureUpperHeight);

  /// Gets the maximum lower height among all the musical symbols in the measure.
  double get _symbolMaximumLowerHeight =>
      musicalSymbolsMetricses.map((symbol) => symbol.lowerHeight).max;

  /// Returns the height of the lower part of the measure.
  double get _measureLowerHeight => metadata.measureLowerHeight;

  /// Returns the maximum height of the measure lower part.
  double get lowerHeight => max(_symbolMaximumLowerHeight, _measureLowerHeight);

  /// Gets the sum of the horizontal margins of all the musical symbols in the measure.
  double get horizontalMarginSum =>
      musicalSymbolsMetricses.map((symbol) => symbol.margin.horizontal).sum;

  /// Gets the thickness of the staff lines in the measure.
  double get staffLineThickness => metadata.staffLineThickness;

  /// Creates a [MeasureRenderer] object for rendering the measure.
  ///
  /// The [layout] parameter is a [SheetMusicLayout] object representing the layout
  /// of the sheet music.
  ///
  /// The [measureInitialX] parameter is the x-coordinate of the measure's origin.
  ///
  /// The [staffLineCenterY] parameter is the y-coordinate of the center of the staff lines.
  MeasureRenderer renderer(
    SheetMusicLayout layout, {
    required double measureInitialX,
    required double staffLineCenterY,
  }) =>
      MeasureRenderer(
        _symbolRenderers(
          layout,
          measureOriginX: measureInitialX,
          staffLineCenterY: staffLineCenterY,
        ),
        this,
        layout,
        measureOriginX: measureInitialX,
        staffLineCenterY: staffLineCenterY,
      );

  List<MusicalSymbolRenderer> _symbolRenderers(
    SheetMusicLayout layout, {
    required double measureOriginX,
    required double staffLineCenterY,
  }) {
    final result = <MusicalSymbolRenderer>[];
    var x = measureOriginX;
    for (final symbol in musicalSymbolsMetricses) {
      result.add(
        symbol.renderer(
          layout,
          staffLineCenterY: staffLineCenterY,
          symbolX: x,
        ),
      );
      x += symbol.width + symbol.margin.horizontal / layout.canvasScale;
    }
    return result;
  }
}
