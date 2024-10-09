import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/measure/measure.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/sheet_music_metrics.dart';
import 'package:simple_sheet_music/src/sheet_music_renderer.dart';
import 'package:xml/xml.dart';

import 'font_types.dart';
import 'music_objects/interface/musical_symbol.dart';
import 'music_objects/key_signature/keysignature_type.dart';
import 'sheet_music_layout.dart';

typedef OnTapMusicObjectCallback = void Function(
  MusicalSymbol musicObject,
  Offset offset,
);

/// The `SimpleSheetMusic` widget is used to display sheet music.
/// It takes a list of `Staff` objects, an initial clef, and other optional parameters to customize the appearance of the sheet music.
class SimpleSheetMusic extends StatefulWidget {
  const SimpleSheetMusic({
    super.key,
    required this.measures,
    this.initialClefType = ClefType.treble,
    this.initialKeySignatureType = KeySignatureType.cMajor,
    this.height = 400.0,
    this.width = 400.0,
    this.lineColor = Colors.black54,
    this.fontType = FontType.bravura,
  });

  /// The list of measures to be displayed.
  final List<Measure> measures;

  /// Receive maximum width and height so as not to break the aspect ratio of the score.
  final double height;

  /// Receive maximum width and height so as not to break the aspect ratio of the score.
  final double width;

  /// The font type to be used for rendering the sheet music.
  final FontType fontType;

  /// The initial clef  for the sheet music.
  final ClefType initialClefType;

  // / The initial keySignature for the sheet music.
  final KeySignatureType initialKeySignatureType;

  /// A callback function that is called when a music object is tapped.
  // final OnTapMusicObjectCallback? onTap;

  final Color lineColor;

  @override
  SimpleSheetMusicState createState() => SimpleSheetMusicState();
}

class _FontData {
  _FontData(this.glyphPath, this.metadata);
  late final GlyphPaths glyphPath;
  late final GlyphMetadata metadata;
}

/// The state class for the SimpleSheetMusic widget.
///
/// This class manages the state of the SimpleSheetMusic widget and handles the initialization,
/// font asset loading, and building of the widget.
class SimpleSheetMusicState extends State<SimpleSheetMusic> {
  late Future<_FontData> _fontData;

  FontType get fontType => widget.fontType;

  @override
  void initState() {
    super.initState();
    _fontData = _loadFonts();
  }

  Future<_FontData> _loadFonts() async {
    final svgFuture = rootBundle.loadString(fontType.svgPath).then((xml) {
      final document = XmlDocument.parse(xml);
      final allGlyphs = document.findAllElements('glyph').toSet();
      return GlyphPaths(allGlyphs);
    });

    final metadataFuture =
        rootBundle.loadString(fontType.metadataPath).then((json) {
      return GlyphMetadata(jsonDecode(json) as Map<String, dynamic>);
    });

    return Future.wait([metadataFuture, svgFuture]).then((list) {
      return _FontData(
        list[1] as GlyphPaths,
        list[0] as GlyphMetadata,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final targetSize = Size(widget.width, widget.height);
    return FutureBuilder<_FontData>(
      future: _fontData,
      builder: (context, fontData) {
        if (fontData.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        final metricsBuilder = SheetMusicMetrics(
          widget.measures,
          widget.initialClefType,
          widget.initialKeySignatureType,
          fontData.requireData.metadata,
          fontData.requireData.glyphPath,
        );
        final layout = SheetMusicLayout(
          metricsBuilder,
          widget.lineColor,
          widgetWidth: widget.width,
          widgetHeight: widget.height,
        );
        return GestureDetector(
          onTap: () {
            // print('Tapped');
          },
          child: CustomPaint(
            size: targetSize,
            painter: SheetMusicRenderer(layout),
          ),
        );
      },
    );
  }
}
