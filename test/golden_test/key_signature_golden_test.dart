@Tags(['golden'])

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';

import 'alchemist_config.dart';

void main() {
  group('KeySignature Golden Tests', () {
    goldenTest(
      'sharp key signatures render correctly',
      fileName: 'key_signature_sharps',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints.tightFor(
          width: 250,
          height: 200,
        ),
        children: [
          GoldenTestScenario(
            name: 'G major (1#)',
            child: _buildKeySignatureWidget(KeySignature.gMajor()),
          ),
          GoldenTestScenario(
            name: 'D major (2#)',
            child: _buildKeySignatureWidget(KeySignature.dMajor()),
          ),
          GoldenTestScenario(
            name: 'A major (3#)',
            child: _buildKeySignatureWidget(KeySignature.aMajor()),
          ),
          GoldenTestScenario(
            name: 'E major (4#)',
            child: _buildKeySignatureWidget(KeySignature.eMajor()),
          ),
        ],
      ),
    );

    goldenTest(
      'flat key signatures render correctly',
      fileName: 'key_signature_flats',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints.tightFor(
          width: 250,
          height: 200,
        ),
        children: [
          GoldenTestScenario(
            name: 'F major (1b)',
            child: _buildKeySignatureWidget(KeySignature.fMajor()),
          ),
          GoldenTestScenario(
            name: 'Bb major (2b)',
            child: _buildKeySignatureWidget(KeySignature.bFlatMajor()),
          ),
          GoldenTestScenario(
            name: 'Eb major (3b)',
            child: _buildKeySignatureWidget(KeySignature.eFlatMajor()),
          ),
          GoldenTestScenario(
            name: 'Ab major (4b)',
            child: _buildKeySignatureWidget(KeySignature.aFlatMajor()),
          ),
        ],
      ),
    );

    goldenTest(
      'key signatures with different clefs',
      fileName: 'key_signature_clefs',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints.tightFor(
          width: 250,
          height: 200,
        ),
        children: [
          GoldenTestScenario(
            name: 'D major treble',
            child: _buildKeySignatureWithClefWidget(
              KeySignature.dMajor(),
              Clef.treble(),
            ),
          ),
          GoldenTestScenario(
            name: 'D major bass',
            child: _buildKeySignatureWithClefWidget(
              KeySignature.dMajor(),
              Clef.bass(),
            ),
          ),
        ],
      ),
    );
  });
}

Widget _buildKeySignatureWidget(KeySignature keySignature) {
  return GoldenTestWrapper(
    child: SimpleSheetMusic(
      measures: [
        Measure([
          Clef.treble(),
          keySignature,
        ]),
      ],
      height: 150,
      width: 230,
    ),
  );
}

Widget _buildKeySignatureWithClefWidget(KeySignature keySignature, Clef clef) {
  return GoldenTestWrapper(
    child: SimpleSheetMusic(
      measures: [
        Measure([
          clef,
          keySignature,
        ]),
      ],
      height: 150,
      width: 230,
    ),
  );
}
