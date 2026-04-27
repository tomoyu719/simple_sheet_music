import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/measure/measure.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';
import 'package:simple_sheet_music/src/musical_context.dart';
import 'package:simple_sheet_music/src/staff/staff_renderer.dart';

/// Represents a staff in sheet music, containing multiple measures.
class Staff implements MusicalSymbol {
  /// Creates a new instance of the [Staff] class.
  ///
  /// The [measures] parameter is a list of measures that make up the staff.
  const Staff(
    this.measures, {
    this.color = Colors.black,
    this.margin = EdgeInsets.zero,
  });

  /// The list of measures that make up the staff.
  final List<Measure> measures;

  @override
  final Color color;

  @override
  final EdgeInsets margin;

  /// Sets the context for the staff and returns a StaffRenderer.
  ///
  /// The [context] parameter is the musical context in which the staff is being rendered.
  /// The [metadata] parameter provides metadata for the glyphs used in the staff.
  /// The [paths] parameter provides the paths for the glyphs used in the staff.
  ///
  /// Returns a [StaffRenderer] object representing the renderer for this staff.
  @override
  MusicalSymbolRenderer setContext(
    MusicalContext context,
    GlyphMetadata metadata,
    GlyphPaths paths,
  ) {
    final measureRenderers = <dynamic>[];
    var currentContext = context;
    for (final measure in measures) {
      final measureRenderer = measure.setContext(currentContext, metadata, paths);
      currentContext = measure.updateContext(currentContext);
      measureRenderers.add(measureRenderer);
    }
    return StaffRenderer(measureRenderers.cast(), staff: this);
  }

  /// Updates the musical context based on the measures in this staff.
  MusicalContext updateContext(MusicalContext context) {
    var currentContext = context;
    for (final measure in measures) {
      currentContext = measure.updateContext(currentContext);
    }
    return currentContext;
  }
}
