import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/constants.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/music_objects/barline/barline_type.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';
import 'package:simple_sheet_music/src/musical_context.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

/// Represents a barline symbol.
///
/// This class is internal and not exported from the library.
/// Use [BarlineType] with `Measure.startBarlineType` and `Measure.endBarlineType`.
class Barline implements MusicalSymbol {
  const Barline({
    this.barlineType = BarlineType.single,
    this.margin = EdgeInsets.zero,
    this.color = Colors.black,
  });

  /// The type of the barline.
  final BarlineType barlineType;

  @override
  final Color color;

  @override
  final EdgeInsets margin;

  @override
  MusicalSymbolRenderer setContext(
    MusicalContext context,
    GlyphMetadata metadata,
    GlyphPaths paths,
  ) =>
      BarlineRenderer(this, metadata);
}

/// Renders the barline symbol and provides its metrics.
///
/// This class is internal and not exported from the library.
class BarlineRenderer implements MusicalSymbolRenderer {
  const BarlineRenderer(
    this.barline,
    this.metadata,
  );

  final GlyphMetadata metadata;
  final Barline barline;

  /// The barline type.
  BarlineType get barlineType => barline.barlineType;

  /// The color of the barline.
  Color get color => barline.color;

  /// Whether this barline should be rendered.
  bool get shouldRender => barlineType != BarlineType.none;

  /// Thickness of thin barline from metadata.
  double get thinThickness => metadata.thinBarlineThickness;

  /// Thickness of thick barline from metadata.
  double get thickThickness => metadata.thickBarlineThickness;

  /// Separation between barlines from metadata.
  double get separation => metadata.barlineSeparation;

  /// Height of the barline (spans the full staff).
  double get barlineHeight => Constants.staffSpace * 4;

  @override
  double get width {
    switch (barlineType) {
      case BarlineType.none:
        return 0;
      case BarlineType.single:
        return thinThickness;
      case BarlineType.double:
        return thinThickness * 2 + separation;
      case BarlineType.final_:
        return thinThickness + separation + thickThickness;
    }
  }

  @override
  double get upperHeight => Constants.staffSpace * 2;

  @override
  double get lowerHeight => Constants.staffSpace * 2;

  @override
  EdgeInsets get margin => barline.margin;

  @override
  void render(
    Canvas canvas, {
    required SheetMusicLayout layout,
    required double staffLineCenterY,
    required double symbolX,
  }) {
    if (!shouldRender) {
      return;
    }

    final x = symbolX + margin.left / layout.canvasScale;
    final topY = staffLineCenterY - barlineHeight / 2;

    switch (barlineType) {
      case BarlineType.none:
        break;
      case BarlineType.single:
        _drawThinLine(canvas, x, topY);
        break;
      case BarlineType.double:
        _drawThinLine(canvas, x, topY);
        _drawThinLine(canvas, x + thinThickness + separation, topY);
        break;
      case BarlineType.final_:
        _drawThinLine(canvas, x, topY);
        _drawThickLine(canvas, x + thinThickness + separation, topY);
        break;
    }
  }

  void _drawThinLine(Canvas canvas, double x, double topY) {
    canvas.drawRect(
      Rect.fromLTWH(x, topY, thinThickness, barlineHeight),
      Paint()..color = color,
    );
  }

  void _drawThickLine(Canvas canvas, double x, double topY) {
    canvas.drawRect(
      Rect.fromLTWH(x, topY, thickThickness, barlineHeight),
      Paint()..color = color,
    );
  }

  @override
  bool isHit(
    Offset position, {
    required SheetMusicLayout layout,
    required double staffLineCenterY,
    required double symbolX,
  }) {
    if (!shouldRender) {
      return false;
    }

    final x = symbolX + margin.left / layout.canvasScale;
    final topY = staffLineCenterY - barlineHeight / 2;
    final hitArea = Rect.fromLTWH(x, topY, width, barlineHeight);

    return hitArea.contains(position);
  }
}
