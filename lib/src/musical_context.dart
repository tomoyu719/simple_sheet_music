import 'package:simple_sheet_music/src/music_objects/clef/clef.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol.dart';
import 'package:simple_sheet_music/src/music_objects/key_signature/key_signature.dart';
import 'package:simple_sheet_music/src/music_objects/key_signature/keysignature_type.dart';

/// Represents the musical context, including the clef type and key signature type.
class MusicalContext {
  /// Creates a new instance of [MusicalContext] with the given [clefType] and [keySignatureType].
  const MusicalContext(this.clefType, this.keySignatureType);

  /// The type of clef used in the musical context.
  final ClefType clefType;

  /// The type of key signature used in the musical context.
  final KeySignatureType keySignatureType;

  MusicalContext update(MusicalSymbol symbol) {
    if (symbol is Clef) {
      return updateWith(clefType: symbol.clefType);
    }
    if (symbol is KeySignature) {
      return updateWith(keySignatureType: symbol.keySignatureType);
    }
    return this;
  }

  MusicalContext updateWith({
    ClefType? clefType,
    KeySignatureType? keySignatureType,
  }) {
    return MusicalContext(
      clefType ?? this.clefType,
      keySignatureType ?? this.keySignatureType,
    );
  }
}
