import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';

/// Represents the type of a key signature.
enum KeySignatureType {
  cMajor(0, '', isSharp: false, isFlat: false),
  aMinor(0, '', isSharp: false, isFlat: false),
  gMajor(1, _sharpKey, isSharp: true, isFlat: false),
  eMinor(1, _sharpKey, isSharp: true, isFlat: false),
  dMajor(2, _sharpKey, isSharp: true, isFlat: false),
  bMinor(2, _sharpKey, isSharp: true, isFlat: false),
  aMajor(3, _sharpKey, isSharp: true, isFlat: false),
  fSharpMinor(3, _sharpKey, isSharp: true, isFlat: false),
  eMajor(4, _sharpKey, isSharp: true, isFlat: false),
  cSharpMinor(4, _sharpKey, isSharp: true, isFlat: false),
  bMajor(5, _sharpKey, isSharp: true, isFlat: false),
  gSharpMinor(5, _sharpKey, isSharp: true, isFlat: false),
  fSharpMajor(6, _sharpKey, isSharp: true, isFlat: false),
  dSharpMinor(6, _sharpKey, isSharp: true, isFlat: false),
  cSharpMajor(7, _sharpKey, isSharp: true, isFlat: false),
  aSharpMinor(7, _sharpKey, isSharp: true, isFlat: false),
  fMajor(1, _flatKey, isSharp: false, isFlat: true),
  dMinor(1, _flatKey, isSharp: false, isFlat: true),
  bFlatMajor(2, _flatKey, isSharp: false, isFlat: true),
  gMinor(2, _flatKey, isSharp: false, isFlat: true),
  eFlatMajor(3, _flatKey, isSharp: false, isFlat: true),
  cMinor(3, _flatKey, isSharp: false, isFlat: true),
  aFlatMajor(4, _flatKey, isSharp: false, isFlat: true),
  fMinor(4, _flatKey, isSharp: false, isFlat: true),
  dFlatMajor(5, _flatKey, isSharp: false, isFlat: true),
  bFlatMinor(5, _flatKey, isSharp: false, isFlat: true),
  gFlatMajor(6, _flatKey, isSharp: false, isFlat: true),
  eFlatMinor(6, _flatKey, isSharp: false, isFlat: true),
  cFlatMajor(7, _flatKey, isSharp: false, isFlat: true),
  aFlatMinor(7, _flatKey, isSharp: false, isFlat: true);

  /// Creates a [KeySignatureType] instance.
  ///
  /// The [keyNum] represents the number of keys in the key signature.
  /// The [pathKey] is the path of the key symbol.
  /// The [isSharp] indicates whether the key signature uses sharps.
  /// The [isFlat] indicates whether the key signature uses flats.
  const KeySignatureType(
    this.keyNum,
    this.pathKey, {
    required this.isSharp,
    required this.isFlat,
  }) : assert(!(isSharp && isFlat));

  /// The number of keys in the key signature.
  final int keyNum;

  /// The path of the key symbol.
  final String pathKey;

  /// Indicates whether the key signature uses sharps.
  final bool isSharp;

  /// Indicates whether the key signature uses flats.
  final bool isFlat;

  static const _flatKey = 'uniE260';
  static const _sharpKey = 'uniE262';

  /// Returns the default offset space for the key signature.
  int get defaultOffsetSpace => isSharp ? 1 : 0;

  /// Returns whether the key signature has parts.
  bool get hasParts =>
      this != KeySignatureType.cMajor && this != KeySignatureType.aMinor;

  /// Returns the positions of the key signature on the staff for the given [clefType].
  List<int> keySignaturePositions(ClefType clefType) => isSharp
      ? clefType.sharpKeySignaturePositions.sublist(0, keyNum)
      : clefType.flatKeySignaturePositions.sublist(0, keyNum);
}
