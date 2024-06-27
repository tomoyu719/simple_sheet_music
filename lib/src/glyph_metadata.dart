import 'package:simple_sheet_music/src/constants.dart';

class GlyphMetadata {
  const GlyphMetadata(this.metadata);
  final Map<String, dynamic> metadata;
  double get staffLineThickness =>
      (metadata['engravingDefaults']['staffLineThickness'] as double) *
      staffSpace;
}
