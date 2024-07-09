import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_metrics.dart';
import 'package:simple_sheet_music/src/musical_context.dart';

import '../mock/mocks.dart';

void main() {
  test('Measure should throw an AssertionError if musicalSymbols list is empty',
      () {
    expect(() => Measure([]), throwsA(isA<AssertionError>()));
  });

  test('Measure should set the context', () {
    const context = MusicalContext(ClefType.treble, KeySignatureType.cMajor);

    final musicalSymbols = [
      const Clef(ClefType.treble),
      MockMusicalSymbol(),
      const Clef(ClefType.bass),
      MockMusicalSymbol(),
    ];
    final measure = Measure(musicalSymbols);

    final symbolMetricses =
        measure.setContext(context, MockGlyphMetadata(), MockGlyphPath());

    expect(
      (symbolMetricses[1] as MockMusicalSymbolMetrics).clefType,
      ClefType.treble,
    );
    expect(
      (symbolMetricses[3] as MockMusicalSymbolMetrics).clefType,
      ClefType.bass,
    );
  });
  test('Measure should return a list of musical symbol metrics', () {
    const initialClefType = ClefType.treble;
    const initialKeySignatureType = KeySignatureType.cMajor;
    const context = MusicalContext(initialClefType, initialKeySignatureType);

    final musicalSymbols = [MockMusicalSymbol(), MockMusicalSymbol()];
    final measure = Measure(musicalSymbols);

    final metrics =
        measure.setContext(context, MockGlyphMetadata(), MockGlyphPath());

    expect(metrics, isA<List<MusicalSymbolMetrics>>());
    expect(metrics.length, musicalSymbols.length);
  });

  test('Measure should return the last clef type', () {
    final musicalSymbols = [
      const Clef(ClefType.treble),
      MockMusicalSymbol(),
      const Clef(ClefType.bass),
      MockMusicalSymbol(),
    ];
    final measure = Measure(musicalSymbols);
    final lastClefType = measure.lastClefType;

    expect(lastClefType, ClefType.bass);
  });

  test('Measure should return the last key signature type', () {
    final musicalSymbols = [
      const KeySignature(KeySignatureType.cMajor),
      MockMusicalSymbol(),
      const KeySignature(KeySignatureType.aMinor),
      MockMusicalSymbol(),
    ];
    final measure = Measure(musicalSymbols);
    final lastKeySignatureType = measure.lastKeySignatureType;

    expect(lastKeySignatureType, KeySignatureType.aMinor);
  });

  test('Measure should update the musical context', () {
    const initialClefType = ClefType.treble;
    const initialKeySignatureType = KeySignatureType.cMajor;
    const initialContext =
        MusicalContext(initialClefType, initialKeySignatureType);

    final musicalSymbols = [
      const Clef(ClefType.bass),
      MockMusicalSymbol(),
      const KeySignature(KeySignatureType.aMinor),
      MockMusicalSymbol(),
    ];
    final measure = Measure(musicalSymbols);
    final updatedContext = measure.updateContext(initialContext);

    expect(updatedContext.clefType, ClefType.bass);
    expect(updatedContext.keySignatureType, KeySignatureType.aMinor);
  });
}
