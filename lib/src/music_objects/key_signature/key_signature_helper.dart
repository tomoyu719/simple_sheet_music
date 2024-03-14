import 'key_signature.dart';

List<KeySignaturePart> keySignatureParts(List<int> keySignaturePartPositions,
        {required bool isSharp}) =>
    List.generate(
        keySignaturePartPositions.length,
        (index) => isSharp
            ? KeySignaturePart.sharp(keySignaturePartPositions[index])
            : KeySignaturePart.flat(keySignaturePartPositions[index]));
