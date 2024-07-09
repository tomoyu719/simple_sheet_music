/// Represents the type of a note head in sheet music.
enum NoteHeadType {
  /// Represents a whole note head.
  whole(pathKey: _wholePathKey, metadataKey: _wholeMetadataKey),

  /// Represents a half note head.
  half(pathKey: _halfPathKey, metadataKey: _halfMetadataKey),

  /// Represents a black note head.
  black(pathKey: _blackPathKey, metadataKey: _blackMetadataKey);

  const NoteHeadType({required this.pathKey, required this.metadataKey});

  /// The key used to retrieve the path of the note head's SVG image.
  final String pathKey;

  /// The key used to retrieve the metadata of the note head.
  final String metadataKey;

  static const _wholePathKey = 'uniE0A2';
  static const _halfPathKey = 'uniE0A3';
  static const _blackPathKey = 'uniE0A4';
  static const _wholeMetadataKey = '';
  static const _halfMetadataKey = 'noteheadHalf';
  static const _blackMetadataKey = 'noteheadBlack';
}
