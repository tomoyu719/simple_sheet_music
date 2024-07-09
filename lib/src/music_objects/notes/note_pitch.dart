/// Enum representing the pitch of a musical note.
enum Pitch {
  a0(0), // Pitch A0
  b0(1), // Pitch B0
  c1(2), // Pitch C1
  d1(3), // Pitch D1
  e1(4), // Pitch E1
  f1(5), // Pitch F1
  g1(6), // Pitch G1
  a1(7), // Pitch A1
  b1(8), // Pitch B1
  c2(9), // Pitch C2
  d2(10), // Pitch D2
  e2(11), // Pitch E2
  f2(12), // Pitch F2
  g2(13), // Pitch G2
  a2(14), // Pitch A2
  b2(15), // Pitch B2
  c3(16), // Pitch C3
  d3(17), // Pitch D3
  e3(18), // Pitch E3
  f3(19), // Pitch F3
  g3(20), // Pitch G3
  a3(21), // Pitch A3
  b3(22), // Pitch B3
  c4(23), // Pitch C4
  d4(24), // Pitch D4
  e4(25), // Pitch E4
  f4(26), // Pitch F4
  g4(27), // Pitch G4
  a4(28), // Pitch A4
  b4(29), // Pitch B4
  c5(30), // Pitch C5
  d5(31), // Pitch D5
  e5(32), // Pitch E5
  f5(33), // Pitch F5
  g5(34), // Pitch G5
  a5(35), // Pitch A5
  b5(36), // Pitch B5
  c6(37), // Pitch C6
  d6(38), // Pitch D6
  e6(39), // Pitch E6
  f6(40), // Pitch F6
  g6(41), // Pitch G6
  a6(42), // Pitch A6
  b6(43), // Pitch B6
  c7(44), // Pitch C7
  d7(45), // Pitch D7
  e7(46), // Pitch E7
  f7(47), // Pitch F7
  g7(48), // Pitch G7
  a7(49), // Pitch A7
  b7(50), // Pitch B7
  c8(51); // Pitch C8

  const Pitch(this.position);

  final int position;

  /// Returns the pitch that is `n` positions higher than the current pitch.
  Pitch get up => upN(1);

  /// Returns the pitch that is `n` positions lower than the current pitch.
  Pitch get down => downN(1);

  /// Returns the pitch that is `n` octaves higher than the current pitch.
  Pitch get upOctave => upN(7);

  /// Returns the pitch that is `n` octaves lower than the current pitch.
  Pitch get downOctave => downN(7);

  /// Returns the pitch that is `n` positions higher than the current pitch.
  Pitch upN(int n) {
    final current = position + n;
    if (current >= Pitch.c8.position) {
      return Pitch.c8;
    }
    return Pitch.values[current];
  }

  /// Returns the pitch that is `n` positions lower than the current pitch.
  Pitch downN(int n) {
    final current = position - n;
    if (current <= Pitch.a0.position) {
      return Pitch.a0;
    }
    return Pitch.values[current];
  }

  /// Returns `true` if the current pitch is greater than or equal to the given [other] pitch.
  bool operator >=(Pitch other) => position >= other.position;

  /// Returns `true` if the current pitch is less than or equal to the given [other] pitch.
  bool operator <=(Pitch other) => position <= other.position;
}
