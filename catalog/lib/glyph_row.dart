import 'package:flutter/material.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';

class GlyphRow extends StatelessWidget {
  const GlyphRow({
    super.key,
    required this.name,
    required this.codepoint,
    required this.bravuraMeasure,
    required this.petalumaMeasure,
  });

  final String name;
  final String codepoint;
  final Measure bravuraMeasure;
  final Measure petalumaMeasure;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  codepoint,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const Text(
                  'Bravura',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
                SizedBox(
                  height: 80,
                  child: SimpleSheetMusic(
                    measures: [bravuraMeasure],
                    fontType: FontType.bravura,
                    height: 80,
                    width: 120,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const Text(
                  'Petaluma',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
                SizedBox(
                  height: 80,
                  child: SimpleSheetMusic(
                    measures: [petalumaMeasure],
                    fontType: FontType.petaluma,
                    height: 80,
                    width: 120,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
