/// Represents the type of a time signature.
///
/// This abstract class hierarchy supports both symbol-based time signatures
/// (common time, cut time) and numeric time signatures with arbitrary
/// numerator and denominator values.
abstract class TimeSignatureType {
  const TimeSignatureType();

  /// The numerator (top number) of the time signature.
  int get numerator;

  /// The denominator (bottom number) of the time signature.
  int get denominator;
}

/// Common time (4/4) represented by the "C" symbol.
class CommonTimeSignature extends TimeSignatureType {
  const CommonTimeSignature();

  @override
  int get numerator => 4;

  @override
  int get denominator => 4;

  /// The SMuFL glyph key for the common time symbol.
  String get pathKey => 'uniE08A';
}

/// Cut time (2/2) represented by the "₵" symbol.
class CutTimeSignature extends TimeSignatureType {
  const CutTimeSignature();

  @override
  int get numerator => 2;

  @override
  int get denominator => 2;

  /// The SMuFL glyph key for the cut time symbol.
  String get pathKey => 'uniE08B';
}

/// Numeric time signature with arbitrary numerator and denominator.
///
/// Both numerator and denominator must be between 1 and 99 inclusive.
class NumericTimeSignature extends TimeSignatureType {
  const NumericTimeSignature(this.numerator, this.denominator)
      : assert(numerator >= 1 && numerator <= 99,
            'Numerator must be between 1 and 99'),
        assert(denominator >= 1 && denominator <= 99,
            'Denominator must be between 1 and 99');

  @override
  final int numerator;

  @override
  final int denominator;
}
