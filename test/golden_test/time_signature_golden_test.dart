@Tags(['golden'])
import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';

import 'alchemist_config.dart';

void main() {
  group('Time Signature Golden Tests', () {
    goldenTest(
      'symbol time signatures render correctly',
      fileName: 'time_signature_symbols',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints.tightFor(
          width: 200,
          height: 200,
        ),
        children: [
          GoldenTestScenario(
            name: 'common time (C)',
            child: _buildMeasureWithTimeSignature(
                const TimeSignature.commonTime()),
          ),
          GoldenTestScenario(
            name: 'cut time',
            child:
                _buildMeasureWithTimeSignature(const TimeSignature.cutTime()),
          ),
        ],
      ),
    );

    goldenTest(
      'common numeric time signatures render correctly',
      fileName: 'time_signature_common_numeric',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints.tightFor(
          width: 200,
          height: 200,
        ),
        children: [
          GoldenTestScenario(
            name: '4/4',
            child:
                _buildMeasureWithTimeSignature(const TimeSignature.fourFour()),
          ),
          GoldenTestScenario(
            name: '3/4',
            child:
                _buildMeasureWithTimeSignature(const TimeSignature.threeFour()),
          ),
          GoldenTestScenario(
            name: '2/4',
            child:
                _buildMeasureWithTimeSignature(const TimeSignature.twoFour()),
          ),
          GoldenTestScenario(
            name: '6/8',
            child:
                _buildMeasureWithTimeSignature(const TimeSignature.sixEight()),
          ),
        ],
      ),
    );

    goldenTest(
      'compound and custom time signatures render correctly',
      fileName: 'time_signature_custom',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints.tightFor(
          width: 200,
          height: 200,
        ),
        children: [
          GoldenTestScenario(
            name: '9/8',
            child:
                _buildMeasureWithTimeSignature(const TimeSignature.nineEight()),
          ),
          GoldenTestScenario(
            name: '12/8',
            child: _buildMeasureWithTimeSignature(
                const TimeSignature.twelveEight()),
          ),
          GoldenTestScenario(
            name: '5/4',
            child: _buildMeasureWithTimeSignature(TimeSignature(5, 4)),
          ),
          GoldenTestScenario(
            name: '7/8',
            child: _buildMeasureWithTimeSignature(TimeSignature(7, 8)),
          ),
        ],
      ),
    );

    goldenTest(
      'multi-digit time signatures render correctly',
      fileName: 'time_signature_multi_digit',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints.tightFor(
          width: 200,
          height: 200,
        ),
        children: [
          GoldenTestScenario(
            name: '15/16',
            child: _buildMeasureWithTimeSignature(TimeSignature(15, 16)),
          ),
          GoldenTestScenario(
            name: '11/8',
            child: _buildMeasureWithTimeSignature(TimeSignature(11, 8)),
          ),
        ],
      ),
    );

    goldenTest(
      'time signature with custom color',
      fileName: 'time_signature_colored',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints.tightFor(
          width: 200,
          height: 200,
        ),
        children: [
          GoldenTestScenario(
            name: 'red common time',
            child: _buildMeasureWithTimeSignature(
                const TimeSignature.commonTime(color: Colors.red)),
          ),
          GoldenTestScenario(
            name: 'blue 4/4',
            child: _buildMeasureWithTimeSignature(
                const TimeSignature.fourFour(color: Colors.blue)),
          ),
        ],
      ),
    );

    goldenTest(
      'time signature in measure context with clef and key signature',
      fileName: 'time_signature_in_measure',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints.tightFor(
          width: 400,
          height: 200,
        ),
        children: [
          GoldenTestScenario(
            name: 'with clef and key signature',
            child: _buildFullMeasure(),
          ),
        ],
      ),
    );

    goldenTest(
      'time signature placement after clef and key signature',
      fileName: 'time_signature_placement',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints.tightFor(
          width: 400,
          height: 200,
        ),
        children: [
          GoldenTestScenario(
            name: 'clef + key + time',
            child: _buildMeasureWithClefKeyTime(),
          ),
          GoldenTestScenario(
            name: 'clef only + time',
            child: _buildMeasureWithClefTime(),
          ),
        ],
      ),
    );
  });
}

Widget _buildMeasureWithTimeSignature(TimeSignature timeSignature) {
  return GoldenTestWrapper(
    child: SimpleSheetMusic(
      musicalSymbols: [
        Measure([
          const Clef.treble(),
          timeSignature,
        ]),
      ],
      height: 150,
      width: 180,
    ),
  );
}

Widget _buildFullMeasure() {
  return GoldenTestWrapper(
    child: SimpleSheetMusic(
      musicalSymbols: [
        Measure([
          const Clef.treble(),
          const KeySignature.gMajor(),
          const TimeSignature.fourFour(),
        ]),
      ],
      height: 150,
      width: 380,
    ),
  );
}

Widget _buildMeasureWithClefKeyTime() {
  return GoldenTestWrapper(
    child: SimpleSheetMusic(
      musicalSymbols: [
        Measure([
          const Clef.treble(),
          const KeySignature.dMajor(),
          const TimeSignature.commonTime(),
        ]),
      ],
      height: 150,
      width: 380,
    ),
  );
}

Widget _buildMeasureWithClefTime() {
  return GoldenTestWrapper(
    child: SimpleSheetMusic(
      musicalSymbols: [
        Measure([
          const Clef.bass(),
          const TimeSignature.threeFour(),
        ]),
      ],
      height: 150,
      width: 380,
    ),
  );
}
