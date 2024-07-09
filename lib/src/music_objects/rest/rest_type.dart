/// Enum representing different types of rests in sheet music.
enum RestType {
  whole(_wholePathKey, offsetSpace: 1),
  half(_halfPathKey),
  quarter(_quarterPathKey),
  eighth(_eighthPathKey),
  sixteenth(_sixteenthPathKey),
  thirtySecond(_thirtySecondPathKey),
  sixtyFourth(_sixtyFourthPathKey),
  hundredTwentyEighth(_hundredTwentyEighthPathKey);

  const RestType(this.pathKey, {this.offsetSpace = 0});

  /// The key used to retrieve the path of the rest symbol.
  final String pathKey;

  /// The number of offset spaces for the rest symbol.
  final int offsetSpace;

  static const _wholePathKey = 'uniE4E3';
  static const _halfPathKey = 'uniE4E4';
  static const _quarterPathKey = 'uniE4E5';
  static const _eighthPathKey = 'uniE4E6';
  static const _sixteenthPathKey = 'uniE4E7';
  static const _thirtySecondPathKey = 'uniE4E8';
  static const _sixtyFourthPathKey = 'uniE4E9';
  static const _hundredTwentyEighthPathKey = 'uniE4EA';
}
