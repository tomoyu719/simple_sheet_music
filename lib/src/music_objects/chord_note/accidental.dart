enum Accidental {
  flat(_flatPathKey),
  natural(_naturalPathKey),
  sharp(_sharpPathKey),
  doubleSharp(_doubleSharpPathKey),
  doubleFlat(_doubleFlatPathKey);

  const Accidental(this.pathKey);
  final String pathKey;
  static const _flatPathKey = 'uniE260';
  static const _naturalPathKey = 'uniE261';
  static const _sharpPathKey = 'uniE262';
  static const _doubleSharpPathKey = 'uniE263';
  static const _doubleFlatPathKey = 'uniE264';
}
