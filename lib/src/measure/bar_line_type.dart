/// The type of bar line to draw at the end of a measure.
enum BarLineType {
  /// No bar line.
  none,

  /// A single thin bar line (default).
  single,

  /// Two thin bar lines side by side.
  double_,

  /// A thin bar line followed by a thick bar line (final bar).
  final_,
}
