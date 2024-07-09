import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/constants.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_metrics.dart';
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
  MusicalSymbolMetrics setContext(
    MusicalContext context,
    GlyphMetadata metadata,
    GlyphPaths paths,
  ) =>
      RestMetrics(
        this,
        context,
        metadata,
        paths,
      );
}

/// Represents the metrics of a rest in sheet music.
class RestMetrics implements MusicalSymbolMetrics {
  const RestMetrics(
    this.rest,
    this.context,
    this.metadata,
    this.paths,
  );

  final MusicalContext context;
  final GlyphMetadata metadata;
  final GlyphPaths paths;
  final Rest rest;

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
  MusicalSymbolRenderer renderer(
    SheetMusicLayout layout, {
    required double staffLineCenterY,
    required double symbolX,
  }) =>
      RestRenderer(
        this,
        layout,
        staffLineCenterY: staffLineCenterY,
        symbolX: symbolX,
      );

  @override
  EdgeInsets get margin => rest.margin;
}

/// Renders a rest in sheet music.
class RestRenderer implements MusicalSymbolRenderer {
  const RestRenderer(
    this.restMetrics,
    this.layout, {
    required this.staffLineCenterY,
    required this.symbolX,
  });

  final double staffLineCenterY;
  final double symbolX;
  final RestMetrics restMetrics;
  final SheetMusicLayout layout;

  Offset get renderOffset => Offset(symbolX, staffLineCenterY) + marginOffset;
  Offset get marginOffset =>
      Offset(restMetrics.leftMargin, 0) / layout.canvasScale;

  @override
  bool isHit(Offset position) {
    throw UnimplementedError();
  }

  @override
  void render(Canvas canvas) =>
      canvas.drawPath(renderPath, Paint()..color = restMetrics.rest.color);

  Path get renderPath => restMetrics.path.shift(renderOffset);

  Rect get renderArea => renderPath.getBounds();
}
