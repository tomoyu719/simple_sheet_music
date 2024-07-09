/// Enum representing different types of accidentals in music notation.
enum Accidental {
  flat(_flatPathKey), // Represents a flat accidental.
  natural(_naturalPathKey), // Represents a natural accidental.
  sharp(_sharpPathKey), // Represents a sharp accidental.
  doubleSharp(_doubleSharpPathKey), // Represents a double sharp accidental.
  doubleFlat(_doubleFlatPathKey); // Represents a double flat accidental.

  /// The path key used to retrieve the corresponding symbol for the accidental.
  const Accidental(this.pathKey);

  /// The path key for the flat accidental symbol.
  final String pathKey;

  /// The path key for the flat accidental symbol.
  static const _flatPathKey = 'uniE260';

  /// The path key for the natural accidental symbol.
  static const _naturalPathKey = 'uniE261';

  /// The path key for the sharp accidental symbol.
  static const _sharpPathKey = 'uniE262';

  /// The path key for the double sharp accidental symbol.
  static const _doubleSharpPathKey = 'uniE263';

  /// The path key for the double flat accidental symbol.
  static const _doubleFlatPathKey = 'uniE264';
}
