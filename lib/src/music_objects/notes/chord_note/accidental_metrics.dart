import 'dart:ui';

import 'package:simple_sheet_music/src/music_objects/position_mixin.dart';

/// A class that represents the metrics of an accidental in a chord note.
class AccidentalMetrics with PositionMixin {
  const AccidentalMetrics(this.position, this.pathOnOrigin, this.offsetX);

  /// The x-offset of the accidental.
  final double offsetX;

  /// The width of the accidental.
  double get width => bbox.width;

  /// The position of the accidental within the chord note.
  final int position;

  /// The path of the accidental on the origin.
  final Path pathOnOrigin;

  /// The transformed path of the accidental.
  Path get path =>
      pathOnOrigin.shift(positionOffset(position) + Offset(offsetX, 0));

  /// The bounding box of the accidental.
  Rect get bbox => path.getBounds();
}
