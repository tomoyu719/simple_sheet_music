import 'package:flutter/material.dart';

import 'package:simple_sheet_music/src/constants.dart';
import 'package:simple_sheet_music/src/extension/list_extension.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';
import 'package:simple_sheet_music/src/music_objects/key_signature/keysignature_type.dart';
import 'package:simple_sheet_music/src/musical_context.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

class KeySignature implements MusicalSymbol {
  const KeySignature.cMajor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.cMajor;

  const KeySignature.aMinor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.aMinor;

  const KeySignature.gMajor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.gMajor;

  const KeySignature.eMinor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.eMinor;

  const KeySignature.dMajor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.dMajor;

  const KeySignature.bMinor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.bMinor;

  const KeySignature.aMajor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.aMajor;

  const KeySignature.fSharpMinor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.fSharpMinor;

  const KeySignature.eMajor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.eMajor;

  const KeySignature.cSharpMinor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.cSharpMinor;

  const KeySignature.bMajor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.bMajor;

  const KeySignature.gSharpMinor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.gSharpMinor;

  const KeySignature.fSharpMajor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.fSharpMajor;

  const KeySignature.dSharpMinor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.dSharpMinor;

  const KeySignature.cSharpMajor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.cSharpMajor;

  const KeySignature.aSharpMinor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.aSharpMinor;

  const KeySignature.fMajor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.fMajor;

  const KeySignature.dMinor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.dMinor;

  const KeySignature.bFlatMajor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.bFlatMajor;

  const KeySignature.gMinor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.gMinor;

  const KeySignature.eFlatMajor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.eFlatMajor;

  const KeySignature.cMinor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.cMinor;

  const KeySignature.aFlatMajor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.aFlatMajor;

  const KeySignature.fMinor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.fMinor;

  const KeySignature.dFlatMajor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.dFlatMajor;

  const KeySignature.bFlatMinor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.bFlatMinor;

  const KeySignature.gFlatMajor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.gFlatMajor;

  const KeySignature.eFlatMinor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.eFlatMinor;

  const KeySignature.cFlatMajor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.cFlatMajor;

  const KeySignature.aFlatMinor({
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : keySignatureType = KeySignatureType.aFlatMinor;

  final KeySignatureType keySignatureType;

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
      KeySignatureRenderer(
        this,
        context,
        metadata,
        paths,
      );
}

class KeySignatureRenderer implements MusicalSymbolRenderer {
  KeySignatureRenderer(
    this.keySignature,
    this.context,
    this.metadata,
    this.paths,
  );

  final MusicalContext context;
  final GlyphMetadata metadata;
  final GlyphPaths paths;
  final KeySignature keySignature;

  // Metrics properties

  bool get hasParts => keySignatureType.hasParts;
  Path? get keySignaturePartPath =>
      hasParts ? paths.parsePath(keySignatureType.pathKey) : null;

  List<KeySignaturePart>? _keySignaturePartsCache;
  List<KeySignaturePart> get keySignatureParts {
    if (_keySignaturePartsCache != null) {
      return _keySignaturePartsCache!;
    }
    _keySignaturePartsCache = hasParts
        ? keySignaturePositionOffsets
            .map(
              (offset) => KeySignaturePart(keySignaturePartPath!.shift(offset)),
            )
            .toList()
        : [];
    return _keySignaturePartsCache!;
  }

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
  EdgeInsets get margin => keySignature.margin;

  // Rendering methods

  @override
  void render(
    Canvas canvas, {
    required SheetMusicLayout layout,
    required double staffLineCenterY,
    required double symbolX,
  }) {
    final renderOffset = Offset(symbolX, staffLineCenterY);
    for (final part in keySignatureParts) {
      part.render(
        canvas,
        renderOffset,
        keySignature.color,
      );
    }
  }

  @override
  bool isHit(
    Offset position, {
    required SheetMusicLayout layout,
    required double staffLineCenterY,
    required double symbolX,
  }) {
    throw UnimplementedError();
  }

  /// Returns the render area for the given position.
  Rect renderArea(double staffLineCenterY, double symbolX) =>
      overallBbox.shift(Offset(symbolX, staffLineCenterY));
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
