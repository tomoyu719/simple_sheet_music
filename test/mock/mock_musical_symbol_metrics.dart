import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_metrics.dart';
import 'package:simple_sheet_music/src/music_objects/key_signature/keysignature_type.dart';
import 'package:simple_sheet_music/src/musical_context.dart';

class MockMusicalSymbolMetrics extends Fake implements MusicalSymbolMetrics {
  MockMusicalSymbolMetrics({
    this.context,
    this.width = 0,
    this.upperHeight = 0,
    this.lowerHeight = 0,
    this.margin = EdgeInsets.zero,
  });
  ClefType? get clefType => context?.clefType;
  KeySignatureType? get keySignatureType => context?.keySignatureType;
  final MusicalContext? context;
  @override
  final double width;
  @override
  final double upperHeight;
  @override
  final double lowerHeight;
  @override
  final EdgeInsets margin;
}
