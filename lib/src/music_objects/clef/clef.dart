import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/constants.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';
import 'package:simple_sheet_music/src/musical_context.dart';

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
  ClefRenderer(
    this.clef,
    this.paths,
  );

  final GlyphPaths paths;
  final Clef clef;

  // Position state
  double _canvasScale = 1;
  double _staffLineCenterY = 0;
  double _symbolX = 0;

  @override
  void setPosition({
    required double canvasScale,
    required double staffLineCenterY,
    required double symbolX,
  }) {
    _canvasScale = canvasScale;
    _staffLineCenterY = staffLineCenterY;
    _symbolX = symbolX;
  }

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
  void render(Canvas canvas) {
    final p = Paint()..color = color;
    canvas.drawPath(_renderPath, p);
  }

  @override
  bool isHit(Offset position) => _renderArea.contains(position);

  Offset get _renderOffset =>
      Offset(_symbolX, _staffLineCenterY) + _marginOffset;

  Offset get _marginOffset => Offset(marginLeft, 0) / _canvasScale;

  Rect get _renderArea => bbox.shift(_renderOffset);

  Path get _renderPath => path.shift(_renderOffset);
}
