import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/measure/measure.dart';
import 'package:simple_sheet_music/src/measure/measure_renderer.dart';
import 'package:simple_sheet_music/src/musical_context.dart';

import 'mocks.dart';

class MockMeasure extends Fake implements Measure {
  MockMeasure({this.isNewLine = false});

  @override
  final bool isNewLine;

  @override
  Color get color => Colors.black;

  @override
  EdgeInsets get margin => EdgeInsets.zero;

  @override
  MeasureRenderer setContext(
    MusicalContext context,
    GlyphMetadata metadata,
    GlyphPaths paths,
  ) =>
      MeasureRenderer([], MockGlyphMetadata(), isNewLine: isNewLine, measure: this);

  @override
  MusicalContext updateContext(MusicalContext context) => context;
}
