@Tags(['golden'])

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';

import 'alchemist_config.dart';

void main() {
  group('Rest Golden Tests', () {
    goldenTest(
      'basic rest types render correctly',
      fileName: 'rest_basic',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints.tightFor(
          width: 200,
          height: 200,
        ),
        children: [
          GoldenTestScenario(
            name: 'whole rest',
            child: _buildRestWidget(RestType.whole),
          ),
          GoldenTestScenario(
            name: 'half rest',
            child: _buildRestWidget(RestType.half),
          ),
          GoldenTestScenario(
            name: 'quarter rest',
            child: _buildRestWidget(RestType.quarter),
          ),
          GoldenTestScenario(
            name: 'eighth rest',
            child: _buildRestWidget(RestType.eighth),
          ),
        ],
      ),
    );

    goldenTest(
      'flagged rest types render correctly',
      fileName: 'rest_flagged',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints.tightFor(
          width: 200,
          height: 200,
        ),
        children: [
          GoldenTestScenario(
            name: '16th rest',
            child: _buildRestWidget(RestType.sixteenth),
          ),
          GoldenTestScenario(
            name: '32nd rest',
            child: _buildRestWidget(RestType.thirtySecond),
          ),
          GoldenTestScenario(
            name: '64th rest',
            child: _buildRestWidget(RestType.sixtyFourth),
          ),
        ],
      ),
    );
  });
}

Widget _buildRestWidget(RestType restType) {
  return GoldenTestWrapper(
    child: SimpleSheetMusic(
      measures: [
        Measure([
          Clef.treble(),
          Rest(restType),
        ]),
      ],
      height: 150,
      width: 180,
    ),
  );
}
