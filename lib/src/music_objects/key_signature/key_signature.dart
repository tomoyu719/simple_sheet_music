import 'package:flutter/material.dart';

import 'package:simple_sheet_music/src/constants.dart';
import 'package:simple_sheet_music/src/extension/list_extension.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_metrics.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';
import 'package:simple_sheet_music/src/music_objects/key_signature/keysignature_type.dart';
import 'package:simple_sheet_music/src/musical_context.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

class KeySignature implements MusicalSymbol {
  const KeySignature(
    this.keySignatureType, {
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  });
  final KeySignatureType keySignatureType;

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
      KeySignatureMetrics(
        this,
        context,
        metadata,
        paths,
      );
}

class KeySignatureMetrics implements MusicalSymbolMetrics {
  const KeySignatureMetrics(
    this.keySignature,
    this.context,
    this.metadata,
    this.paths,
  );
  final MusicalContext context;
  final GlyphMetadata metadata;
  final GlyphPaths paths;
  bool get hasParts => keySignatureType.hasParts;
  Path? get keySignaturePartPath =>
      hasParts ? paths.parsePath(keySignatureType.pathKey) : null;

  List<KeySignaturePart> get keySignatureParts => hasParts
      ? keySignaturePositionOffsets
          .map(
            (offset) => KeySignaturePart(keySignaturePartPath!.shift(offset)),
          )
          .toList()
      : [];

  ClefType get clefType => context.clefType;

  List<int> get keySignaturePositions =>
      keySignatureType.keySignaturePositions(clefType);
  List<Offset> get keySignaturePositionOffsets {
    final result = <Offset>[];
    for (var i = 0; i < keySignaturePositions.length; i++) {
      final position = keySignaturePositions[i];
      result.add(
        Offset(
          i * keySignaturePartWidth,
          -1 * 1 / 2 * position * Constants.staffSpace,
        ),
      );
    }
    return result;
  }

  Rect get keySignaturePartBbox =>
      hasParts ? keySignaturePartPath!.getBounds() : Rect.zero;
  Offset get defaultOffset => Offset(
        0,
        -1 * keySignatureType.defaultOffsetSpace * Constants.staffSpace,
      );

  Rect get overallBbox => hasParts
      ? keySignatureParts
          .map((e) => e.bbox)
          .reduce((a, b) => a.expandToInclude(b))
      : Rect.zero;

  double get keySignaturePartWidth => hasParts ? keySignaturePartBbox.width : 0;
  final KeySignature keySignature;
  KeySignatureType get keySignatureType => keySignature.keySignatureType;

  @override
  double get lowerHeight =>
      hasParts ? keySignatureParts.map((e) => e.lowerHeight).max : 0;

  @override
  double get upperHeight =>
      hasParts ? keySignatureParts.map((e) => e.upperHeight).min : 0;

  @override
  double get width => _objectWidth;

  double get _objectWidth =>
      hasParts ? keySignatureParts.map((e) => e.width).sum : 0;

  @override
  MusicalSymbolRenderer renderer(
    SheetMusicLayout layout, {
    required double staffLineCenterY,
    required double symbolX,
  }) =>
      KeySignatureRenderer(
        keySignatureParts,
        this,
        symbolX: symbolX,
        staffLineCenterY: staffLineCenterY,
      );

  @override
  EdgeInsets get margin => keySignature.margin;
}

class KeySignatureRenderer implements MusicalSymbolRenderer {
  const KeySignatureRenderer(
    this.keySignatureParts,
    this.keySignature, {
    required this.symbolX,
    required this.staffLineCenterY,
  });
  final double staffLineCenterY;
  final double symbolX;
  Offset get renderOffset => Offset(symbolX, staffLineCenterY);

  final List<KeySignaturePart> keySignatureParts;
  final KeySignatureMetrics keySignature;

  @override
  void render(Canvas canvas) {
    for (final part in keySignatureParts) {
      part.render(
        canvas,
        renderOffset,
        keySignature.keySignature.color,
      );
    }
  }

  @override
  bool isHit(Offset position) {
    throw UnimplementedError();
  }

  Rect get renderArea => keySignature.overallBbox.shift(renderOffset);
}

class KeySignaturePart {
  const KeySignaturePart(this.path);

  final Path path;

  Rect get bbox => path.getBounds();
  double get lowerHeight => bbox.bottom;

  double get upperHeight => -bbox.top;

  double get width => bbox.width;

  void render(Canvas canvas, Offset renderOffset, Color color) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path.shift(renderOffset), paint);
  }

  Rect renderArea(Offset renderArea) => bbox.shift(renderArea);
}
