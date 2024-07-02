enum Pitch {
  a0(0),
  b0(1),
  c1(2),
  d1(3),
  e1(4),
  f1(5),
  g1(6),
  a1(7),
  b1(8),
  c2(9),
  d2(10),
  e2(11),
  f2(12),
  g2(13),
  a2(14),
  b2(15),
  c3(16),
  d3(17),
  e3(18),
  f3(19),
  g3(20),
  a3(21),
  b3(22),
  c4(23),
  d4(24),
  e4(25),
  f4(26),
  g4(27),
  a4(28),
  b4(29),
  c5(30),
  d5(31),
  e5(32),
  f5(33),
  g5(34),
  a5(35),
  b5(36),
  c6(37),
  d6(38),
  e6(39),
  f6(40),
  g6(41),
  a6(42),
  b6(43),
  c7(44),
  d7(45),
  e7(46),
  f7(47),
  g7(48),
  a7(49),
  b7(50),
  c8(51);

  const Pitch(this.position);

  final int position;

  Pitch get up => upN(1);
  Pitch get down => downN(1);
  Pitch get upOctave => upN(7);
  Pitch get downOctave => downN(7);

  Pitch upN(int n) {
    final current = position + n;
    if (current >= Pitch.c8.position) {
      return Pitch.c8;
    }
    return Pitch.values[current];
  }

  Pitch downN(int n) {
    final current = position - n;
    if (current <= Pitch.a0.position) {
      return Pitch.a0;
    }
    return Pitch.values[current];
  }
}
