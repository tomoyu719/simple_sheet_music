import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/constants.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';
import 'package:simple_sheet_music/src/music_objects/rest/rest_type.dart';
import 'package:simple_sheet_music/src/musical_context.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

/// Represents a rest in sheet music.
class Rest implements MusicalSymbol {
  const Rest(
    this.restType, {
    this.margin = const EdgeInsets.all(10),
    this.color = Colors.black,
  });

  @override
  final Color color;

  @override
  final EdgeInsets margin;

  final RestType restType;

  @override
  MusicalSymbolRenderer setContext(
    MusicalContext context,
    GlyphMetadata metadata,
    GlyphPaths paths,
  ) =>
      RestRenderer(
        this,
        context,
        metadata,
        paths,
      );
}

/// Renders a rest in sheet music and provides its metrics.
class RestRenderer implements MusicalSymbolRenderer {
  const RestRenderer(
    this.rest,
    this.context,
    this.metadata,
    this.paths,
  );

  final MusicalContext context;
  final GlyphMetadata metadata;
  final GlyphPaths paths;
  final Rest rest;

  // Metrics properties

  RestType get restType => rest.restType;

  Offset get defaultOffset =>
      Offset(0, -1 * restType.offsetSpace * Constants.staffSpace);

  Path get path => paths.parsePath(rest.restType.pathKey).shift(defaultOffset);
  Rect get bbox => path.getBounds();

  @override
  double get lowerHeight => bbox.bottom;

  double get leftMargin => rest.margin.left;

  @override
  double get upperHeight => -bbox.top;

  @override
  double get width => bbox.width;

  @override
  EdgeInsets get margin => rest.margin;

  // Rendering methods

  @override
  bool isHit(
    Offset position, {
    required SheetMusicLayout layout,
    required double staffLineCenterY,
    required double symbolX,
  }) {
    throw UnimplementedError();
  }

  @override
  void render(
    Canvas canvas, {
    required SheetMusicLayout layout,
    required double staffLineCenterY,
    required double symbolX,
  }) =>
      canvas.drawPath(
        _renderPath(layout, staffLineCenterY, symbolX),
        Paint()..color = rest.color,
      );

  Offset _renderOffset(
    SheetMusicLayout layout,
    double staffLineCenterY,
    double symbolX,
  ) =>
      Offset(symbolX, staffLineCenterY) + _marginOffset(layout);

  Offset _marginOffset(SheetMusicLayout layout) =>
      Offset(leftMargin, 0) / layout.canvasScale;

  Path _renderPath(
    SheetMusicLayout layout,
    double staffLineCenterY,
    double symbolX,
  ) =>
      path.shift(_renderOffset(layout, staffLineCenterY, symbolX));

  /// Returns the render area for the given position.
  Rect renderArea(
    SheetMusicLayout layout,
    double staffLineCenterY,
    double symbolX,
  ) =>
      _renderPath(layout, staffLineCenterY, symbolX).getBounds();
}
