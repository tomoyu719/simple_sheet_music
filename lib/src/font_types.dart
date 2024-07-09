enum FontType {
  bravura(svgPath: bravuraSvgPath, metadataPath: bravuraMetadataPath),
  petaluma(svgPath: petalumaSvgPath, metadataPath: petalumaMetadataPath);

  const FontType({required this.svgPath, required this.metadataPath});

  static const bravuraSvgPath =
      'packages/simple_sheet_music/assets/Bravura.svg';
  static const bravuraMetadataPath =
      'packages/simple_sheet_music/assets/bravura_metadata.json';
  static const petalumaSvgPath =
      'packages/simple_sheet_music/assets/Petaluma.svg';
  static const petalumaMetadataPath =
      'packages/simple_sheet_music/assets/petaluma_metadata.json';

  final String svgPath;
  final String metadataPath;
}
