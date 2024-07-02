enum NoteHeadType {
  whole(pathKey: _wholePathKey, metadataKey: _wholeMetadataKey),
  half(pathKey: _halfPathKey, metadataKey: _halfMetadataKey),
  black(pathKey: _blackPathKey, metadataKey: _blackMetadataKey);

  const NoteHeadType({required this.pathKey, required this.metadataKey});
  final String pathKey;
  final String metadataKey;
  static const _wholePathKey = 'uniE0A2';
  static const _halfPathKey = 'uniE0A3';
  static const _blackPathKey = 'uniE0A4';
  static const _wholeMetadataKey = '';
  static const _halfMetadataKey = 'noteheadHalf';
  static const _blackMetadataKey = 'noteheadBlack';
}
