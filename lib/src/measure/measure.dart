import 'dart:core';

import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/measure/measure_renderer.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';
import 'package:simple_sheet_music/src/music_objects/key_signature/key_signature.dart';
import 'package:simple_sheet_music/src/music_objects/key_signature/keysignature_type.dart';
import 'package:simple_sheet_music/src/musical_context.dart';

/// Represents a measure in sheet music.
class Measure implements MusicalSymbol {
  /// Creates a new instance of the [Measure] class.
  ///
  /// The [musicalSymbols] parameter is a list of musical symbols that make up the measure.
  /// The [isNewLine] parameter indicates whether the measure is a new line in the sheet music.
  ///
  /// Throws an [AssertionError] if the [musicalSymbols] list is empty.
  const Measure(
    this.musicalSymbols, {
    this.isNewLine = false,
    this.color = Colors.black,
    this.margin = EdgeInsets.zero,
  }) : assert(musicalSymbols.length != 0);

  /// The list of musical symbols that make up the measure.
  final List<MusicalSymbol> musicalSymbols;

  /// Indicates whether the measure is a new line in the sheet music.
  final bool isNewLine;

  @override
  final Color color;

  @override
  final EdgeInsets margin;

  /// Sets the context for the measure and returns a MeasureRenderer.
  ///
  /// The [context] parameter is the musical context in which the measure is being rendered.
  /// The [metadata] parameter provides metadata for the glyphs used in the measure.
  /// The [paths] parameter provides the paths for the glyphs used in the measure.
  ///
  /// Returns a [MeasureRenderer] object representing the renderer for this measure.
  @override
  MeasureRenderer setContext(
    MusicalContext context,
    GlyphMetadata metadata,
    GlyphPaths paths,
  ) {
    final result = <MusicalSymbolRenderer>[];
    var symbolContext = context;
    for (final symbol in musicalSymbols) {
      final symbolRenderer = symbol.setContext(symbolContext, metadata, paths);
      symbolContext = symbolContext.update(symbol);
      result.add(symbolRenderer);
    }
    return MeasureRenderer(result, metadata, isNewLine: isNewLine, measure: this);
  }

  ClefType? get lastClefType {
    for (final symbol in musicalSymbols.reversed) {
      if (symbol is Clef) {
        return symbol.clefType;
      }
    }
    return null;
  }

  KeySignatureType? get lastKeySignatureType {
    for (final symbol in musicalSymbols.reversed) {
      if (symbol is KeySignature) {
        return symbol.keySignatureType;
      }
    }
    return null;
  }

  MusicalContext updateContext(MusicalContext context) => context.updateWith(
        clefType: lastClefType,
        keySignatureType: lastKeySignatureType,
      );
}
