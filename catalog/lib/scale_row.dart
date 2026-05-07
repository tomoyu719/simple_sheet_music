import 'package:flutter/material.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';

/// 1オクターブ分の自然音を表示する行ウィジェット
class ScaleRow extends StatelessWidget {
  const ScaleRow({
    super.key,
    required this.octave,
    required this.pitches,
    required this.clef,
  });

  final int octave;
  final List<Pitch> pitches;
  final Clef clef;

  @override
  Widget build(BuildContext context) {
    final notes = pitches.map(Note.new).toList();

    final pitchRange = pitches.length == 1
        ? pitches.first.name.toUpperCase()
        : '${pitches.first.name.toUpperCase()}-${pitches.last.name.toUpperCase()}';

    // 音符数に応じた幅を計算（1音符あたり約50px + clef分100px）
    final sheetWidth = 100.0 + (notes.length * 50.0);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Octave $octave',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Text(
                '($pitchRange)',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
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
