import 'package:flutter/material.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';

import 'glyph_row.dart';

class GlyphDefinition {
  const GlyphDefinition(
      this.name, this.codepoint, this.bravuraMeasure, this.petalumaMeasure);
  final String name;
  final String codepoint;
  final Measure bravuraMeasure;
  final Measure petalumaMeasure;
}

class GlyphCatalogPage extends StatelessWidget {
  const GlyphCatalogPage({super.key});

  static final glyphs = <GlyphDefinition>[
    // Clefs
    GlyphDefinition('gClef', 'uniE050', Measure([const Clef.treble()]),
        Measure([const Clef.treble()])),
    GlyphDefinition('cClef', 'uniE05C', Measure([const Clef.alto()]),
        Measure([const Clef.alto()])),
    GlyphDefinition('fClef', 'uniE062', Measure([const Clef.bass()]),
        Measure([const Clef.bass()])),

    // Rests
    GlyphDefinition(
        'restWhole',
        'uniE4E3',
        Measure([const Rest(RestType.whole)]),
        Measure([const Rest(RestType.whole)])),
    GlyphDefinition('restHalf', 'uniE4E4', Measure([const Rest(RestType.half)]),
        Measure([const Rest(RestType.half)])),
    GlyphDefinition(
        'restQuarter',
        'uniE4E5',
        Measure([const Rest(RestType.quarter)]),
        Measure([const Rest(RestType.quarter)])),
    GlyphDefinition(
        'rest8th',
        'uniE4E6',
        Measure([const Rest(RestType.eighth)]),
        Measure([const Rest(RestType.eighth)])),
    GlyphDefinition(
        'rest16th',
        'uniE4E7',
        Measure([const Rest(RestType.sixteenth)]),
        Measure([const Rest(RestType.sixteenth)])),
    GlyphDefinition(
        'rest32nd',
        'uniE4E8',
        Measure([const Rest(RestType.thirtySecond)]),
        Measure([const Rest(RestType.thirtySecond)])),
    GlyphDefinition(
        'rest64th',
        'uniE4E9',
        Measure([const Rest(RestType.sixtyFourth)]),
        Measure([const Rest(RestType.sixtyFourth)])),
    GlyphDefinition(
        'rest128th',
        'uniE4EA',
        Measure([const Rest(RestType.hundredTwentyEighth)]),
        Measure([const Rest(RestType.hundredTwentyEighth)])),

    // Noteheads
    GlyphDefinition(
        'noteheadWhole',
        'uniE0A2',
        Measure([const Note(Pitch.c4, noteDuration: NoteDuration.whole)]),
        Measure([const Note(Pitch.c4, noteDuration: NoteDuration.whole)])),
    GlyphDefinition(
        'noteheadHalf',
        'uniE0A3',
        Measure([const Note(Pitch.c4, noteDuration: NoteDuration.half)]),
        Measure([const Note(Pitch.c4, noteDuration: NoteDuration.half)])),
    GlyphDefinition('noteheadBlack', 'uniE0A4', Measure([const Note(Pitch.c4)]),
        Measure([const Note(Pitch.c4)])),

    // Accidentals
    GlyphDefinition(
        'accidentalFlat',
        'uniE260',
        Measure([const Note(Pitch.c4, accidental: Accidental.flat)]),
        Measure([const Note(Pitch.c4, accidental: Accidental.flat)])),
    GlyphDefinition(
        'accidentalNatural',
        'uniE261',
        Measure([const Note(Pitch.c4, accidental: Accidental.natural)]),
        Measure([const Note(Pitch.c4, accidental: Accidental.natural)])),
    GlyphDefinition(
        'accidentalSharp',
        'uniE262',
        Measure([const Note(Pitch.c4, accidental: Accidental.sharp)]),
        Measure([const Note(Pitch.c4, accidental: Accidental.sharp)])),
    GlyphDefinition(
        'accidentalDoubleSharp',
        'uniE263',
        Measure([const Note(Pitch.c4, accidental: Accidental.doubleSharp)]),
        Measure([const Note(Pitch.c4, accidental: Accidental.doubleSharp)])),
    GlyphDefinition(
        'accidentalDoubleFlat',
        'uniE264',
        Measure([const Note(Pitch.c4, accidental: Accidental.doubleFlat)]),
        Measure([const Note(Pitch.c4, accidental: Accidental.doubleFlat)])),

    // Flags (up - lower pitch)
    GlyphDefinition(
        'flag8thUp',
        'uniE240',
        Measure([const Note(Pitch.c4, noteDuration: NoteDuration.eighth)]),
        Measure([const Note(Pitch.c4, noteDuration: NoteDuration.eighth)])),
    GlyphDefinition(
        'flag16thUp',
        'uniE242',
        Measure([const Note(Pitch.c4, noteDuration: NoteDuration.sixteenth)]),
        Measure([const Note(Pitch.c4, noteDuration: NoteDuration.sixteenth)])),
    GlyphDefinition(
        'flag32ndUp',
        'uniE244',
        Measure(
            [const Note(Pitch.c4, noteDuration: NoteDuration.thirtySecond)]),
        Measure(
            [const Note(Pitch.c4, noteDuration: NoteDuration.thirtySecond)])),
    GlyphDefinition(
        'flag64thUp',
        'uniE246',
        Measure([const Note(Pitch.c4, noteDuration: NoteDuration.sixtyFourth)]),
        Measure(
            [const Note(Pitch.c4, noteDuration: NoteDuration.sixtyFourth)])),
    GlyphDefinition(
        'flag128thUp',
        'uniE248',
        Measure([
          const Note(Pitch.c4, noteDuration: NoteDuration.hundredsTwentyEighth)
        ]),
        Measure([
          const Note(Pitch.c4, noteDuration: NoteDuration.hundredsTwentyEighth)
        ])),

    // Flags (down - higher pitch)
    GlyphDefinition(
        'flag8thDown',
        'uniE241',
        Measure([const Note(Pitch.a5, noteDuration: NoteDuration.eighth)]),
        Measure([const Note(Pitch.a5, noteDuration: NoteDuration.eighth)])),
    GlyphDefinition(
        'flag16thDown',
        'uniE243',
        Measure([const Note(Pitch.a5, noteDuration: NoteDuration.sixteenth)]),
        Measure([const Note(Pitch.a5, noteDuration: NoteDuration.sixteenth)])),
    GlyphDefinition(
        'flag32ndDown',
        'uniE245',
        Measure(
            [const Note(Pitch.a5, noteDuration: NoteDuration.thirtySecond)]),
        Measure(
            [const Note(Pitch.a5, noteDuration: NoteDuration.thirtySecond)])),
    GlyphDefinition(
        'flag64thDown',
        'uniE247',
        Measure([const Note(Pitch.a5, noteDuration: NoteDuration.sixtyFourth)]),
        Measure(
            [const Note(Pitch.a5, noteDuration: NoteDuration.sixtyFourth)])),
    GlyphDefinition(
        'flag128thDown',
        'uniE249',
        Measure([
          const Note(Pitch.a5, noteDuration: NoteDuration.hundredsTwentyEighth)
        ]),
        Measure([
          const Note(Pitch.a5, noteDuration: NoteDuration.hundredsTwentyEighth)
        ])),

    // Barlines
    GlyphDefinition('barlineSingle', 'uniE030', Measure([const Clef.treble()]),
        Measure([const Clef.treble()])),
    GlyphDefinition(
        'barlineDouble',
        'uniE031',
        Measure([const Clef.treble()], endBarlineType: BarlineType.double),
        Measure([const Clef.treble()], endBarlineType: BarlineType.double)),
    GlyphDefinition(
        'barlineFinal',
        'uniE032',
        Measure([const Clef.treble()], endBarlineType: BarlineType.final_),
        Measure([const Clef.treble()], endBarlineType: BarlineType.final_)),

    // Time Signatures
    GlyphDefinition(
        'timeSigCommon',
        'uniE08A',
        Measure([const Clef.treble(), const TimeSignature.commonTime()]),
        Measure([const Clef.treble(), const TimeSignature.commonTime()])),
    GlyphDefinition(
        'timeSigCutCommon',
        'uniE08B',
        Measure([const Clef.treble(), const TimeSignature.cutTime()]),
        Measure([const Clef.treble(), const TimeSignature.cutTime()])),
    GlyphDefinition(
        'timeSig4/4',
        'uniE084',
        Measure([const Clef.treble(), const TimeSignature.fourFour()]),
        Measure([const Clef.treble(), const TimeSignature.fourFour()])),
    GlyphDefinition(
        'timeSig3/4',
        'uniE083',
        Measure([const Clef.treble(), const TimeSignature.threeFour()]),
        Measure([const Clef.treble(), const TimeSignature.threeFour()])),
    GlyphDefinition(
        'timeSig6/8',
        'uniE086',
        Measure([const Clef.treble(), const TimeSignature.sixEight()]),
        Measure([const Clef.treble(), const TimeSignature.sixEight()])),
    GlyphDefinition(
        'timeSig12/8',
        'uniE081+uniE082',
        Measure([const Clef.treble(), const TimeSignature.twelveEight()]),
        Measure([const Clef.treble(), const TimeSignature.twelveEight()])),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: glyphs.length,
      itemBuilder: (context, index) {
        final glyph = glyphs[index];
        return GlyphRow(
          name: glyph.name,
          codepoint: glyph.codepoint,
          bravuraMeasure: glyph.bravuraMeasure,
          petalumaMeasure: glyph.petalumaMeasure,
        );
      },
    );
  }
}
