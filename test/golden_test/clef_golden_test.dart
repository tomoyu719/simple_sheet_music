@Tags(['golden'])

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';

import 'alchemist_config.dart';

void main() {
  group('Clef Golden Tests', () {
    goldenTest(
      'all clef types render correctly',
      fileName: 'clef_types',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints.tightFor(
          width: 200,
          height: 200,
        ),
        children: [
          GoldenTestScenario(
            name: 'treble clef',
            child: _buildClefWidget(Clef.treble()),
          ),
          GoldenTestScenario(
            name: 'bass clef',
            child: _buildClefWidget(Clef.bass()),
          ),
          GoldenTestScenario(
            name: 'alto clef',
            child: _buildClefWidget(Clef.alto()),
          ),
          GoldenTestScenario(
            name: 'tenor clef',
            child: _buildClefWidget(Clef.tenor()),
          ),
        ],
      ),
    );

    goldenTest(
      'clef with custom color',
      fileName: 'clef_colored',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints.tightFor(
          width: 200,
          height: 200,
        ),
        children: [
          GoldenTestScenario(
            name: 'red treble clef',
            child: _buildClefWidget(Clef.treble(color: Colors.red)),
          ),
          GoldenTestScenario(
            name: 'blue bass clef',
            child: _buildClefWidget(Clef.bass(color: Colors.blue)),
          ),
        ],
      ),
    );
  });
}

Widget _buildClefWidget(Clef clef) {
  return GoldenTestWrapper(
    child: SimpleSheetMusic(
      musicalSymbols: [
        Measure([clef]),
      ],
      height: 150,
      width: 180,
    ),
  );
}
