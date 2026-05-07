import 'package:flutter/material.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';

import 'scale_row.dart';

/// 表示モード
enum DisplayMode {
  naturalNotes,
  chromatic,
  durations,
}

extension DisplayModeExtension on DisplayMode {
  String get label {
    switch (this) {
      case DisplayMode.naturalNotes:
        return 'Natural Notes';
      case DisplayMode.chromatic:
        return 'Chromatic';
      case DisplayMode.durations:
        return 'Durations';
    }
  }
}

/// Clefタイプと対応するClefオブジェクトを生成する関数
enum ClefSelection {
  treble,
  bass,
  alto,
  tenor,
}

extension ClefSelectionExtension on ClefSelection {
  String get label {
    switch (this) {
      case ClefSelection.treble:
        return 'Treble';
      case ClefSelection.bass:
        return 'Bass';
      case ClefSelection.alto:
        return 'Alto';
      case ClefSelection.tenor:
        return 'Tenor';
    }
  }

  Clef createClef() {
    switch (this) {
      case ClefSelection.treble:
        return const Clef.treble();
      case ClefSelection.bass:
        return const Clef.bass();
      case ClefSelection.alto:
        return const Clef.alto();
      case ClefSelection.tenor:
        return const Clef.tenor();
    }
  }
}

/// オクターブごとの自然音ピッチ
const Map<int, List<Pitch>> naturalNotesByOctave = {
  0: [Pitch.a0, Pitch.b0],
  1: [Pitch.c1, Pitch.d1, Pitch.e1, Pitch.f1, Pitch.g1, Pitch.a1, Pitch.b1],
  2: [Pitch.c2, Pitch.d2, Pitch.e2, Pitch.f2, Pitch.g2, Pitch.a2, Pitch.b2],
  3: [Pitch.c3, Pitch.d3, Pitch.e3, Pitch.f3, Pitch.g3, Pitch.a3, Pitch.b3],
  4: [Pitch.c4, Pitch.d4, Pitch.e4, Pitch.f4, Pitch.g4, Pitch.a4, Pitch.b4],
  5: [Pitch.c5, Pitch.d5, Pitch.e5, Pitch.f5, Pitch.g5, Pitch.a5, Pitch.b5],
  6: [Pitch.c6, Pitch.d6, Pitch.e6, Pitch.f6, Pitch.g6, Pitch.a6, Pitch.b6],
  7: [Pitch.c7, Pitch.d7, Pitch.e7, Pitch.f7, Pitch.g7, Pitch.a7, Pitch.b7],
  8: [Pitch.c8],
};

/// 比較表示用の音符の長さ
const List<NoteDuration> comparisonDurations = [
  NoteDuration.whole,
  NoteDuration.half,
  NoteDuration.quarter,
  NoteDuration.eighth,
];

class ScaleCatalogPage extends StatefulWidget {
  const ScaleCatalogPage({super.key});

  @override
  State<ScaleCatalogPage> createState() => _ScaleCatalogPageState();
}

class _ScaleCatalogPageState extends State<ScaleCatalogPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DisplayMode _displayMode = DisplayMode.naturalNotes;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: ClefSelection.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Clef選択タブ
        TabBar(
          controller: _tabController,
          tabs: ClefSelection.values.map((c) => Tab(text: c.label)).toList(),
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Colors.grey,
          onTap: (_) => setState(() {}),
        ),
        // 表示モード選択
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SegmentedButton<DisplayMode>(
            segments: DisplayMode.values
                .map((m) => ButtonSegment(value: m, label: Text(m.label)))
                .toList(),
            selected: {_displayMode},
            onSelectionChanged: (selected) {
              setState(() {
                _displayMode = selected.first;
              });
            },
          ),
        ),
        // コンテンツ
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: ClefSelection.values.map(_buildContent).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(ClefSelection clefSelection) {
    switch (_displayMode) {
      case DisplayMode.naturalNotes:
        return _buildNaturalNotesView(clefSelection);
      case DisplayMode.chromatic:
        return _buildChromaticView(clefSelection);
      case DisplayMode.durations:
        return _buildDurationsView(clefSelection);
    }
  }

  Widget _buildNaturalNotesView(ClefSelection clefSelection) {
    final octaves = naturalNotesByOctave.keys.toList()..sort();
    return ListView.builder(
      itemCount: octaves.length,
      itemBuilder: (context, index) {
        final octave = octaves[index];
        final pitches = naturalNotesByOctave[octave]!;
        return ScaleRow(
          octave: octave,
          pitches: pitches,
          clef: clefSelection.createClef(),
        );
      },
    );
  }

  Widget _buildChromaticView(ClefSelection clefSelection) {
    // 半音階表示：各オクターブで12音（臨時記号付き）
    final octaves = [1, 2, 3, 4, 5, 6, 7];
    return ListView.builder(
      itemCount: octaves.length,
      itemBuilder: (context, index) {
        final octave = octaves[index];
        return _ChromaticRow(
          octave: octave,
          clef: clefSelection.createClef(),
        );
      },
    );
  }

  Widget _buildDurationsView(ClefSelection clefSelection) {
    // 代表的なピッチで音符の長さを比較
    final representativePitches = [
      Pitch.c4,
      Pitch.g4,
      Pitch.c5,
      Pitch.g5,
    ];
    return ListView.builder(
      itemCount: representativePitches.length,
      itemBuilder: (context, index) {
        final pitch = representativePitches[index];
        return _DurationComparisonRow(
          pitch: pitch,
          clef: clefSelection.createClef(),
        );
      },
    );
  }
}

/// 半音階表示用の行ウィジェット
class _ChromaticRow extends StatelessWidget {
  const _ChromaticRow({
    required this.octave,
    required this.clef,
  });

  final int octave;
  final Clef clef;

  @override
  Widget build(BuildContext context) {
    final pitches = naturalNotesByOctave[octave]!;

    // 半音階のノートを生成（自然音 + シャープ）
    final chromaticNotes = <Note>[];
    for (final pitch in pitches) {
      // 自然音
      chromaticNotes.add(Note(pitch));
      // C, D, F, G, A にはシャープを追加
      final pitchName = pitch.name;
      if (pitchName.startsWith('c') ||
          pitchName.startsWith('d') ||
          pitchName.startsWith('f') ||
          pitchName.startsWith('g') ||
          pitchName.startsWith('a')) {
        chromaticNotes.add(Note(
          pitch,
          accidental: Accidental.sharp,
        ));
      }
    }

    // 音符数に応じた幅を計算
    final sheetWidth = 100.0 + (chromaticNotes.length * 50.0);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Octave $octave (Chromatic)',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SimpleSheetMusic(
                staffs: [
                  Staff([Measure([clef, ...chromaticNotes])]),
                ],
                height: 120,
                width: sheetWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 音符の長さ比較用の行ウィジェット
class _DurationComparisonRow extends StatelessWidget {
  const _DurationComparisonRow({
    required this.pitch,
    required this.clef,
  });

  final Pitch pitch;
  final Clef clef;

  @override
  Widget build(BuildContext context) {
    final notes = comparisonDurations
        .map((duration) => Note(pitch, noteDuration: duration))
        .toList();

    // 音符数に応じた幅を計算
    final sheetWidth = 100.0 + (notes.length * 80.0);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${pitch.name.toUpperCase()} - Duration Comparison',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            'whole, half, quarter, eighth',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SimpleSheetMusic(
                staffs: [
                  Staff([Measure([clef, ...notes])]),
                ],
                height: 120,
                width: sheetWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
