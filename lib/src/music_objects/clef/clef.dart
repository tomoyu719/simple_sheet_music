import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/constants.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';
import 'package:simple_sheet_music/src/musical_context.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

/// Represents a musical clef symbol.
class Clef implements MusicalSymbol {
  const Clef.treble({
    this.margin = const EdgeInsets.all(10),
    this.color = Colors.black,
  }) : clefType = ClefType.treble;

  const Clef.alto({
    this.margin = const EdgeInsets.all(10),
    this.color = Colors.black,
  }) : clefType = ClefType.alto;

  const Clef.tenor({
    this.margin = const EdgeInsets.all(10),
    this.color = Colors.black,
  }) : clefType = ClefType.tenor;

  const Clef.bass({
    this.margin = const EdgeInsets.all(10),
    this.color = Colors.black,
  }) : clefType = ClefType.bass;

  /// The type of the clef.
  final ClefType clefType;

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
      ClefRenderer(this, paths);
}

/// Renders the clef symbol and provides its metrics.
class ClefRenderer implements MusicalSymbolRenderer {
  const ClefRenderer(
    this.clef,
    this.paths,
  );

  final GlyphPaths paths;
  final Clef clef;

  // Metrics properties

  @override
  double get lowerHeight => bbox.bottom;

  @override
  double get upperHeight => -bbox.top;

  @override
  double get width => bbox.width;

  @override
  EdgeInsets get margin => clef.margin;

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

  // Rendering methods

  @override
  void render(
    Canvas canvas, {
    required SheetMusicLayout layout,
    required double staffLineCenterY,
    required double symbolX,
  }) {
    final p = Paint()..color = color;
    canvas.drawPath(_renderPath(layout, staffLineCenterY, symbolX), p);
  }

  @override
  bool isHit(
    Offset position, {
    required SheetMusicLayout layout,
    required double staffLineCenterY,
    required double symbolX,
  }) =>
      _renderArea(layout, staffLineCenterY, symbolX).contains(position);

  Offset _renderOffset(
    SheetMusicLayout layout,
    double staffLineCenterY,
    double symbolX,
  ) =>
      Offset(symbolX, staffLineCenterY) + _marginOffset(layout);

  Offset _marginOffset(SheetMusicLayout layout) =>
      Offset(marginLeft, 0) / layout.canvasScale;

  Rect _renderArea(
    SheetMusicLayout layout,
    double staffLineCenterY,
    double symbolX,
  ) =>
      bbox.shift(_renderOffset(layout, staffLineCenterY, symbolX));

  Path _renderPath(
    SheetMusicLayout layout,
    double staffLineCenterY,
    double symbolX,
  ) =>
      path.shift(_renderOffset(layout, staffLineCenterY, symbolX));
}
