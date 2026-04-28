import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/extension/list_extension.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/measure/measure.dart';
import 'package:simple_sheet_music/src/measure/measure_renderer.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol.dart';
import 'package:simple_sheet_music/src/music_objects/key_signature/keysignature_type.dart';
import 'package:simple_sheet_music/src/musical_context.dart';
import 'package:simple_sheet_music/src/staff/staff.dart';
import 'package:simple_sheet_music/src/staff/staff_renderer.dart';

/// Represents the layout of the sheet music.
class SheetMusicLayout {
  SheetMusicLayout({
    required this.musicalSymbols,
    required this.initialClefType,
    required this.initialKeySignatureType,
    required this.metadata,
    required this.paths,
    required this.lineColor,
    required this.widgetWidth,
    required this.widgetHeight,
  });

  /// The height of the widget.
  final double widgetHeight;

  /// The width of the widget.
  final double widgetWidth;

  /// The list of musical symbols to be displayed.
  final List<MusicalSymbol> musicalSymbols;

  /// The initial clef type for the sheet music.
  final ClefType initialClefType;

  /// The initial key signature type for the sheet music.
  final KeySignatureType initialKeySignatureType;

  /// The glyph metadata for the sheet music.
  final GlyphMetadata metadata;

  /// The glyph paths for the sheet music.
  final GlyphPaths paths;

  /// The color of the lines in the sheet music.
  final Color lineColor;

  // ---- Measure/Staff generation (from SheetMusicMetrics) ----

  List<MeasureRenderer>? _measureRenderersCache;

  /// Gets the renderers of each measure in the sheet music.
  /// Handles both Measure and Staff inputs.
  List<MeasureRenderer> get _measureRenderers {
    if (_measureRenderersCache != null) {
      return _measureRenderersCache!;
    }
    final result = <MeasureRenderer>[];
    var context = MusicalContext(initialClefType, initialKeySignatureType);

    for (final symbol in musicalSymbols) {
      if (symbol is Measure) {
        final measureRenderer = symbol.setContext(context, metadata, paths);
        context = symbol.updateContext(context);
        result.add(measureRenderer);
      } else if (symbol is Staff) {
        // Staff contains multiple measures
        for (final measure in symbol.measures) {
          final measureRenderer = measure.setContext(context, metadata, paths);
          context = measure.updateContext(context);
          result.add(measureRenderer);
        }
      }
    }

    return _measureRenderersCache ??= result;
  }

  List<StaffRenderer>? _staffRenderersCache;

  /// Gets the renderers of each staff in the sheet music.
  List<StaffRenderer> get staffRenderers {
    if (_staffRenderersCache != null) {
      return _staffRenderersCache!;
    }
    final staffs = <StaffRenderer>[];
    var sameStaffMeasures = <MeasureRenderer>[];
    for (final measure in _measureRenderers) {
      if (measure.isNewLine && sameStaffMeasures.isNotEmpty) {
        staffs.add(StaffRenderer(sameStaffMeasures));
        sameStaffMeasures = [measure];
      } else {
        sameStaffMeasures.add(measure);
      }
    }
    if (sameStaffMeasures.isNotEmpty) {
      staffs.add(StaffRenderer(sameStaffMeasures));
    }
    return _staffRenderersCache ??= staffs;
  }

  /// Gets the staff with the maximum width in the sheet music.
  StaffRenderer get _maximumWidthStaff {
    var result = staffRenderers.first;
    for (final staff in staffRenderers) {
      if (staff.width > result.width) {
        result = staff;
      }
    }
    return result;
  }

  /// Gets the maximum width of a staff in the sheet music.
  double get _maximumStaffWidth => _maximumWidthStaff.width;

  /// The sum of the horizontal margins of all the staffs.
  double get _maximumStaffHorizontalMarginSum =>
      _maximumWidthStaff.horizontalMarginSum;

  /// Gets the sum of the heights of all the staffs in the sheet music.
  double get _staffsHeightSum => staffRenderers.map((staff) => staff.height).sum;

  // ---- Layout calculations ----

  /// The horizontal padding of the sheet music.
  double get _horizontalPadding =>
      widgetWidth -
      (_maximumStaffWidth * canvasScale + _maximumStaffHorizontalMarginSum);

  /// The horizontal padding on the canvas.
  double get _horizontalPaddingOnCanvas => _horizontalPadding / canvasScale;

  /// The left padding on the canvas.
  double get _leftPaddingOnCanvas => _horizontalPaddingOnCanvas / 2;

  /// The vertical padding of the sheet music.
  double get _verticalPadding => widgetHeight - _staffsHeightSum * canvasScale;

  /// The vertical padding on the canvas.
  double get _verticalPaddingOnCanvas => _verticalPadding / canvasScale;

  /// The upper padding on the canvas.
  double get _upperPaddingOnCanvas => _verticalPaddingOnCanvas / 2;

  /// The scale factor for the width of the sheet music.
  double get _widthScale =>
      (widgetWidth - _maximumStaffHorizontalMarginSum) / _maximumStaffWidth;

  /// The scale factor for the height of the sheet music.
  double get _heightScale => widgetHeight / _staffsHeightSum;

  /// The scale factor for the canvas.
  double get canvasScale => min(_widthScale, _heightScale);

  /// Renders the sheet music on the canvas.
  void render(Canvas canvas, Size size) {
    var currentY = _upperPaddingOnCanvas;
    for (final staff in staffRenderers) {
      currentY += staff.upperHeight;
      staff.renderWithSize(
        canvas,
        size,
        layout: this,
        staffLineCenterY: currentY,
        leftPadding: _leftPaddingOnCanvas,
      );
      currentY += staff.lowerHeight;
    }
  }
}
