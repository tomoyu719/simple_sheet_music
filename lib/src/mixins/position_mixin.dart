import 'dart:ui';

import '../measure/staffline.dart';

/// A mixin that provides methods for calculating position offsets in a staff.
mixin HasPosition {
  /// Calculates the vertical offset height based on the given position.
  ///
  /// The position is a numeric value representing the position in the staff.
  /// The offset height is calculated by multiplying the position with the staff line space height
  /// and negating it.
  ///
  /// Returns the calculated offset height.
  double positionOffsetHeight(int position) =>
      -position * StaffLineRenderer.staffLineSpaceHeight / 2;

  /// Calculates the position offset based on the given position.
  ///
  /// The position is a numeric value representing the position in the staff.
  /// The offset is calculated by calling [positionOffsetHeight] and creating an [Offset] object
  /// with x-coordinate 0 and the calculated y-coordinate.
  ///
  /// Returns the calculated position offset.
  Offset getPositionOffset(int position) =>
      Offset(0, positionOffsetHeight(position));
}
