import 'package:flutter/rendering.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_metrics.dart';
import 'package:simple_sheet_music/src/musical_context.dart';

/// An abstract class representing a musical symbol.
///
/// This class serves as the base class for all musical symbols in the
/// application. It provides common properties and methods that are shared
/// among different types of musical symbols.
abstract class MusicalSymbol {
  /// Creates a new instance of the [MusicalSymbol] class.
  ///
  /// The [margin] parameter specifies the margin around the musical symbol.
  /// The [color] parameter specifies the color of the musical symbol.
  const MusicalSymbol(this.color, this.margin);

  /// The margin around the musical symbol. Vertical margin is not used.
  final EdgeInsets margin;

  /// The color of the musical symbol.
  final Color color;

  /// Sets the context for the musical symbol.
  ///
  /// The [context] parameter specifies the musical context in which the
  /// symbol is being rendered. The [metadata] parameter provides additional
  /// metadata about the symbol. The [paths] parameter contains the glyph paths
  /// for the symbol.
  ///
  /// Returns the metrics for the musical symbol.
  MusicalSymbolMetrics setContext(
    MusicalContext context,
    GlyphMetadata metadata,
    GlyphPaths paths,
  );
}
