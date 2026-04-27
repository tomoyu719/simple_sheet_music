import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';
import 'package:simple_sheet_music/src/measure/measure_renderer.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/key_signature/keysignature_type.dart';
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
      const Clef.treble(),
      MockMusicalSymbol(),
      const Clef.bass(),
      MockMusicalSymbol(),
    ];
    final measure = Measure(musicalSymbols);

    final measureRenderer =
        measure.setContext(context, MockGlyphMetadata(), MockGlyphPath());

    expect(
      (measureRenderer.symbolRenderers[1] as MockMusicalSymbolRenderer).clefType,
      ClefType.treble,
    );
    expect(
      (measureRenderer.symbolRenderers[3] as MockMusicalSymbolRenderer).clefType,
      ClefType.bass,
    );
  });
  test('Measure should return a MeasureRenderer', () {
    const initialClefType = ClefType.treble;
    const initialKeySignatureType = KeySignatureType.cMajor;
    const context = MusicalContext(initialClefType, initialKeySignatureType);

    final musicalSymbols = [MockMusicalSymbol(), MockMusicalSymbol()];
    final measure = Measure(musicalSymbols);

    final renderer =
        measure.setContext(context, MockGlyphMetadata(), MockGlyphPath());

    expect(renderer, isA<MeasureRenderer>());
    expect(renderer.symbolRenderers.length, musicalSymbols.length);
  });

  test('Measure should return the last clef type', () {
    final musicalSymbols = [
      const Clef.treble(),
      MockMusicalSymbol(),
      const Clef.bass(),
      MockMusicalSymbol(),
    ];
    final measure = Measure(musicalSymbols);
    final lastClefType = measure.lastClefType;

    expect(lastClefType, ClefType.bass);
  });

  test('Measure should return the last key signature type', () {
    final musicalSymbols = [
      const KeySignature.cMajor(),
      MockMusicalSymbol(),
      const KeySignature.aMinor(),
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
      const Clef.bass(),
      MockMusicalSymbol(),
      const KeySignature.aMinor(),
      MockMusicalSymbol(),
    ];
    final measure = Measure(musicalSymbols);
    final updatedContext = measure.updateContext(initialContext);

    expect(updatedContext.clefType, ClefType.bass);
    expect(updatedContext.keySignatureType, KeySignatureType.aMinor);
  });
}
