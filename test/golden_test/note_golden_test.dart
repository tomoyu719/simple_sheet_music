@Tags(['golden'])

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';

import 'alchemist_config.dart';

void main() {
  group('Note Golden Tests', () {
    goldenTest(
      'note durations render correctly',
      fileName: 'note_durations',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints.tightFor(
          width: 200,
          height: 200,
        ),
        children: [
          GoldenTestScenario(
            name: 'whole note',
            child: _buildNoteWidget(NoteDuration.whole),
          ),
          GoldenTestScenario(
            name: 'half note',
            child: _buildNoteWidget(NoteDuration.half),
          ),
          GoldenTestScenario(
            name: 'quarter note',
            child: _buildNoteWidget(NoteDuration.quarter),
          ),
          GoldenTestScenario(
            name: 'eighth note',
            child: _buildNoteWidget(NoteDuration.eighth),
          ),
        ],
      ),
    );

    goldenTest(
      'flagged notes render correctly',
      fileName: 'note_flagged',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints.tightFor(
          width: 200,
          height: 200,
        ),
        children: [
          GoldenTestScenario(
            name: '16th note',
            child: _buildNoteWidget(NoteDuration.sixteenth),
          ),
          GoldenTestScenario(
            name: '32nd note',
            child: _buildNoteWidget(NoteDuration.thirtySecond),
          ),
          GoldenTestScenario(
            name: '64th note',
            child: _buildNoteWidget(NoteDuration.sixtyFourth),
          ),
        ],
      ),
    );

    goldenTest(
      'notes with accidentals render correctly',
      fileName: 'note_accidentals',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints.tightFor(
          width: 200,
          height: 200,
        ),
        children: [
          GoldenTestScenario(
            name: 'sharp',
            child: _buildNoteWithAccidentalWidget(Accidental.sharp),
          ),
          GoldenTestScenario(
            name: 'flat',
            child: _buildNoteWithAccidentalWidget(Accidental.flat),
          ),
          GoldenTestScenario(
            name: 'natural',
            child: _buildNoteWithAccidentalWidget(Accidental.natural),
          ),
          GoldenTestScenario(
            name: 'double sharp',
            child: _buildNoteWithAccidentalWidget(Accidental.doubleSharp),
          ),
        ],
      ),
    );

    goldenTest(
      'notes at different pitches',
      fileName: 'note_pitches',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints.tightFor(
          width: 200,
          height: 200,
        ),
        children: [
          GoldenTestScenario(
            name: 'C4 (middle C)',
            child: _buildNoteAtPitchWidget(Pitch.c4),
          ),
          GoldenTestScenario(
            name: 'G5 (high)',
            child: _buildNoteAtPitchWidget(Pitch.g5),
          ),
          GoldenTestScenario(
            name: 'E3 (low)',
            child: _buildNoteAtPitchWidget(Pitch.e3),
          ),
        ],
      ),
    );
  });
}

Widget _buildNoteWidget(NoteDuration duration) {
  return GoldenTestWrapper(
    child: SimpleSheetMusic(
      musicalSymbols: [
        Measure([
          Clef.treble(),
          Note(Pitch.b4, noteDuration: duration),
        ]),
      ],
      height: 150,
      width: 180,
    ),
  );
}

Widget _buildNoteWithAccidentalWidget(Accidental accidental) {
  return GoldenTestWrapper(
    child: SimpleSheetMusic(
      musicalSymbols: [
        Measure([
          Clef.treble(),
          Note(Pitch.b4, noteDuration: NoteDuration.quarter, accidental: accidental),
        ]),
      ],
      height: 150,
      width: 180,
    ),
  );
}

Widget _buildNoteAtPitchWidget(Pitch pitch) {
  return GoldenTestWrapper(
    child: SimpleSheetMusic(
      musicalSymbols: [
        Measure([
          Clef.treble(),
          Note(pitch, noteDuration: NoteDuration.quarter),
        ]),
      ],
      height: 150,
      width: 180,
    ),
  );
}
