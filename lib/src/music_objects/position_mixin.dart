import 'dart:ui';

import 'package:simple_sheet_music/src/constants.dart';

/// A mixin that provides a method to calculate the offset position based on a given position.
mixin PositionMixin {
  /// Calculates the offset position based on the given position.
  ///
  /// The calculated offset is determined by multiplying the position by half of the staff space constant
  /// and negating it on the y-axis.
  ///
  /// - [position]: The position for which to calculate the offset.
  ///
  /// Returns the calculated offset as an [Offset] object.
  Offset positionOffset(int position) =>
      Offset(0, -1 * (1 / 2) * position * Constants.staffSpace);
}
