import 'package:flutter/material.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';

import 'glyph_row.dart';

class GlyphDefinition {
  const GlyphDefinition(this.name, this.codepoint, this.bravuraMeasure, this.petalumaMeasure);
  final String name;
  final String codepoint;
  final Measure bravuraMeasure;
  final Measure petalumaMeasure;
}

class GlyphCatalogPage extends StatelessWidget {
  const GlyphCatalogPage({super.key});

  static final List<GlyphDefinition> glyphs = [
    // Clefs
    GlyphDefinition('gClef', 'uniE050', Measure([Clef.treble()]), Measure([Clef.treble()])),
    GlyphDefinition('cClef', 'uniE05C', Measure([Clef.alto()]), Measure([Clef.alto()])),
    GlyphDefinition('fClef', 'uniE062', Measure([Clef.bass()]), Measure([Clef.bass()])),

    // Rests
    GlyphDefinition('restWhole', 'uniE4E3', Measure([Rest(RestType.whole)]), Measure([Rest(RestType.whole)])),
    GlyphDefinition('restHalf', 'uniE4E4', Measure([Rest(RestType.half)]), Measure([Rest(RestType.half)])),
    GlyphDefinition('restQuarter', 'uniE4E5', Measure([Rest(RestType.quarter)]), Measure([Rest(RestType.quarter)])),
    GlyphDefinition('rest8th', 'uniE4E6', Measure([Rest(RestType.eighth)]), Measure([Rest(RestType.eighth)])),
    GlyphDefinition('rest16th', 'uniE4E7', Measure([Rest(RestType.sixteenth)]), Measure([Rest(RestType.sixteenth)])),
    GlyphDefinition('rest32nd', 'uniE4E8', Measure([Rest(RestType.thirtySecond)]), Measure([Rest(RestType.thirtySecond)])),
    GlyphDefinition('rest64th', 'uniE4E9', Measure([Rest(RestType.sixtyFourth)]), Measure([Rest(RestType.sixtyFourth)])),
    GlyphDefinition('rest128th', 'uniE4EA', Measure([Rest(RestType.hundredTwentyEighth)]), Measure([Rest(RestType.hundredTwentyEighth)])),

    // Noteheads
    GlyphDefinition('noteheadWhole', 'uniE0A2', Measure([Note(Pitch.c4, noteDuration: NoteDuration.whole)]), Measure([Note(Pitch.c4, noteDuration: NoteDuration.whole)])),
    GlyphDefinition('noteheadHalf', 'uniE0A3', Measure([Note(Pitch.c4, noteDuration: NoteDuration.half)]), Measure([Note(Pitch.c4, noteDuration: NoteDuration.half)])),
    GlyphDefinition('noteheadBlack', 'uniE0A4', Measure([Note(Pitch.c4)]), Measure([Note(Pitch.c4)])),

    // Accidentals
    GlyphDefinition('accidentalFlat', 'uniE260', Measure([Note(Pitch.c4, accidental: Accidental.flat)]), Measure([Note(Pitch.c4, accidental: Accidental.flat)])),
    GlyphDefinition('accidentalNatural', 'uniE261', Measure([Note(Pitch.c4, accidental: Accidental.natural)]), Measure([Note(Pitch.c4, accidental: Accidental.natural)])),
    GlyphDefinition('accidentalSharp', 'uniE262', Measure([Note(Pitch.c4, accidental: Accidental.sharp)]), Measure([Note(Pitch.c4, accidental: Accidental.sharp)])),
    GlyphDefinition('accidentalDoubleSharp', 'uniE263', Measure([Note(Pitch.c4, accidental: Accidental.doubleSharp)]), Measure([Note(Pitch.c4, accidental: Accidental.doubleSharp)])),
    GlyphDefinition('accidentalDoubleFlat', 'uniE264', Measure([Note(Pitch.c4, accidental: Accidental.doubleFlat)]), Measure([Note(Pitch.c4, accidental: Accidental.doubleFlat)])),

    // Flags (up - lower pitch)
    GlyphDefinition('flag8thUp', 'uniE240', Measure([Note(Pitch.c4, noteDuration: NoteDuration.eighth)]), Measure([Note(Pitch.c4, noteDuration: NoteDuration.eighth)])),
    GlyphDefinition('flag16thUp', 'uniE242', Measure([Note(Pitch.c4, noteDuration: NoteDuration.sixteenth)]), Measure([Note(Pitch.c4, noteDuration: NoteDuration.sixteenth)])),
    GlyphDefinition('flag32ndUp', 'uniE244', Measure([Note(Pitch.c4, noteDuration: NoteDuration.thirtySecond)]), Measure([Note(Pitch.c4, noteDuration: NoteDuration.thirtySecond)])),
    GlyphDefinition('flag64thUp', 'uniE246', Measure([Note(Pitch.c4, noteDuration: NoteDuration.sixtyFourth)]), Measure([Note(Pitch.c4, noteDuration: NoteDuration.sixtyFourth)])),
    GlyphDefinition('flag128thUp', 'uniE248', Measure([Note(Pitch.c4, noteDuration: NoteDuration.hundredsTwentyEighth)]), Measure([Note(Pitch.c4, noteDuration: NoteDuration.hundredsTwentyEighth)])),

    // Flags (down - higher pitch)
    GlyphDefinition('flag8thDown', 'uniE241', Measure([Note(Pitch.a5, noteDuration: NoteDuration.eighth)]), Measure([Note(Pitch.a5, noteDuration: NoteDuration.eighth)])),
    GlyphDefinition('flag16thDown', 'uniE243', Measure([Note(Pitch.a5, noteDuration: NoteDuration.sixteenth)]), Measure([Note(Pitch.a5, noteDuration: NoteDuration.sixteenth)])),
    GlyphDefinition('flag32ndDown', 'uniE245', Measure([Note(Pitch.a5, noteDuration: NoteDuration.thirtySecond)]), Measure([Note(Pitch.a5, noteDuration: NoteDuration.thirtySecond)])),
    GlyphDefinition('flag64thDown', 'uniE247', Measure([Note(Pitch.a5, noteDuration: NoteDuration.sixtyFourth)]), Measure([Note(Pitch.a5, noteDuration: NoteDuration.sixtyFourth)])),
    GlyphDefinition('flag128thDown', 'uniE249', Measure([Note(Pitch.a5, noteDuration: NoteDuration.hundredsTwentyEighth)]), Measure([Note(Pitch.a5, noteDuration: NoteDuration.hundredsTwentyEighth)])),
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
