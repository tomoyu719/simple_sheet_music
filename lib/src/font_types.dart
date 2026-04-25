import 'package:simple_sheet_music/src/fonts/bravura_glyphs.dart';
import 'package:simple_sheet_music/src/fonts/bravura_metadata.dart';
import 'package:simple_sheet_music/src/fonts/petaluma_glyphs.dart';
import 'package:simple_sheet_music/src/fonts/petaluma_metadata.dart';

enum FontType {
  bravura(glyphsData: BravuraGlyphs, metadataData: BravuraMetadata),
  petaluma(glyphsData: PetalumaGlyphs, metadataData: PetalumaMetadata);

  const FontType({required this.glyphsData, required this.metadataData});

  final Map<String, dynamic> glyphsData;
  final Map<String, dynamic> metadataData;

  Map<String, dynamic> get glyphs => glyphsData['glyphs'] as Map<String, dynamic>;
}
