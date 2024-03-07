enum FontType {
  bravura(path: bravuraPath, name: bravuraName);
  // bravura(path: bravuraPath, name: bravuraName),
  // petaluma(path: petalumaPath, name: petalumaName);

  static const bravuraPath = 'packages/simple_sheet_music/assets/Bravura.otf';
  static const bravuraName = 'Bravura';
  static const petalumaPath = 'packages/simple_sheet_music/assets/Petaluma.otf';
  static const petalumaName = 'Petaluma';

  final String path;
  final String name;
  const FontType({required this.path, required this.name});
}
