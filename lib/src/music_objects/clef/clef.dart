import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/constants.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_metrics.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';
import 'package:simple_sheet_music/src/musical_context.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

/// Represents a musical clef symbol.
class Clef implements MusicalSymbol {
  const Clef(
    this.clefType, {
    this.margin = const EdgeInsets.all(10),
    this.color = Colors.black,
  });

  /// The type of the clef.
  final ClefType clefType;

  @override
  final Color color;

  @override
  final EdgeInsets margin;

  @override
  MusicalSymbolMetrics setContext(
    MusicalContext context,
    GlyphMetadata metadata,
    GlyphPaths paths,
  ) =>
      ClefMetrics(this, paths);
}

/// Represents the metrics of a clef symbol.
class ClefMetrics implements MusicalSymbolMetrics {
  const ClefMetrics(
    this.clef,
    this.paths,
  );

  final GlyphPaths paths;

  final Clef clef;

  @override
  double get lowerHeight => bbox.bottom;

  @override
  double get upperHeight => -bbox.top;

  @override
  double get width => bbox.width;

  /// Gets the path of the clef symbol on the origin.
  Path get originPath => paths.parsePath(clefType.pathKey);

  /// Gets the bounding box of the clef symbol on the origin.
  Rect get bboxOnOrigin => originPath.getBounds();

  /// Gets the default offset of the clef symbol. The default offset is the offset that places the clef symbol at the origin.
  Offset get defaultOffset => Offset(
        -bboxOnOrigin.left,
        clefType.offsetSpace * Constants.staffSpace,
      );

  /// Gets the path of the clef symbol.
  Path get path => originPath.shift(defaultOffset);

  /// Gets the bounding box of the clef symbol.
  Rect get bbox => path.getBounds();

  /// Gets the type of the clef.
  ClefType get clefType => clef.clefType;

  /// Gets the color of the clef symbol.
  Color get color => clef.color;

  /// Gets the left margin of the clef symbol.
  double get marginLeft => clef.margin.left;

  @override
  MusicalSymbolRenderer renderer(
    SheetMusicLayout layout, {
    required double staffLineCenterY,
    required double symbolX,
  }) =>
      ClefRenderer(
        this,
        layout,
        symbolX: symbolX,
        staffLineCenterY: staffLineCenterY,
      );

  @override
  EdgeInsets get margin => clef.margin;
}

/// Renders the clef symbol.
class ClefRenderer implements MusicalSymbolRenderer {
  const ClefRenderer(
    this.clef,
    this.layout, {
    required this.symbolX,
    required this.staffLineCenterY,
  });

  final ClefMetrics clef;
  final double symbolX;
  final double staffLineCenterY;

  @override
  void render(Canvas canvas) {
    final p = Paint()..color = clef.color;
    canvas.drawPath(renderPath, p);
  }

  @override
  bool isHit(Offset position) => renderArea.contains(position);

  Offset get renderOffset => Offset(symbolX, staffLineCenterY) + marginOffset;

  Offset get marginOffset => Offset(clef.marginLeft, 0) / layout.canvasScale;

  final SheetMusicLayout layout;

  Rect get renderArea => clef.bbox.shift(renderOffset);

  Path get renderPath => clef.path.shift(renderOffset);
}
