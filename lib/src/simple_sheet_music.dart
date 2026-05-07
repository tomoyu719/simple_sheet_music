import 'dart:core';

import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/time_signature/time_signature_type.dart';
import 'package:simple_sheet_music/src/sheet_music_metrics.dart';
import 'package:simple_sheet_music/src/sheet_music_renderer.dart';
import 'package:simple_sheet_music/src/staff/staff.dart';

import 'font_types.dart';
import 'music_objects/key_signature/keysignature_type.dart';
import 'sheet_music_layout.dart';

typedef OnTapMusicObjectCallback = void Function(
  Staff staff,
  Offset offset,
);

/// The `SimpleSheetMusic` widget is used to display sheet music.
/// It takes a list of `Staff` objects, an initial clef, and other optional parameters to customize the appearance of the sheet music.
class SimpleSheetMusic extends StatelessWidget {
  const SimpleSheetMusic({
    super.key,
    required this.staffs,
    this.initialClefType = ClefType.treble,
    this.initialKeySignatureType = KeySignatureType.cMajor,
    this.initialTimeSignatureType,
    this.height = 400.0,
    this.width = 400.0,
    this.lineColor = Colors.black54,
    this.fontType = FontType.bravura,
  });

  /// The list of staffs to be displayed.
  final List<Staff> staffs;

  /// Receive maximum width and height so as not to break the aspect ratio of the score.
  final double height;

  /// Receive maximum width and height so as not to break the aspect ratio of the score.
  final double width;

  /// The font type to be used for rendering the sheet music.
  final FontType fontType;

  /// The initial clef  for the sheet music.
  final ClefType initialClefType;

  /// The initial keySignature for the sheet music.
  final KeySignatureType initialKeySignatureType;

  /// The initial timeSignature for the sheet music.
  final TimeSignatureType? initialTimeSignatureType;

  /// The color of the staff lines.
  final Color lineColor;

  @override
  Widget build(BuildContext context) {
    final glyphPath = GlyphPaths(fontType.glyphs);
    final metadata = GlyphMetadata(fontType.metadataData);
    final targetSize = Size(width, height);
    final metricsBuilder = SheetMusicMetrics(
      staffs,
      initialClefType,
      initialKeySignatureType,
      initialTimeSignatureType,
      metadata,
      glyphPath,
    );
    final layout = SheetMusicLayout(
      metricsBuilder,
      lineColor,
      widgetWidth: width,
      widgetHeight: height,
    );
    return CustomPaint(
      size: targetSize,
      painter: SheetMusicRenderer(layout),
    );
  }
}
