import 'dart:math';
import 'dart:ui';

import 'package:simple_sheet_music/src/constants.dart';
import 'package:simple_sheet_music/src/music_objects/notes/stem_direction.dart';

import '../clef/clef_type.dart';
import 'note_pitch.dart';

/// Represents a position on a musical stave.
///
/// The [StavePosition] class provides methods to calculate the local position
/// of a note on the stave based on the clef type. It also defines the minimum
/// and maximum positions on the stave.
class StavePosition {
  /// Creates a [StavePosition] with the given global position.
  const StavePosition(this.pitch, this.clefType);

  final Pitch pitch;
  final ClefType clefType;

  int get _globalPosition => pitch.position;

  /// Calculates the local position of the note on the stave based on the clef type.
  ///
  /// The local position is calculated by subtracting the clef type's global position
  /// on the center of the staff lines from the global position of the note.
  ///
  /// Returns the local position of the note.
  int get localPosition => _globalPosition - clefType.positionOnCenter;

  /// Returns the position offset.
  /// -1 means Flutter canvas y-axis is pointing downwards.
  /// 1/2 means one position is half a staff space.
  Offset get positionOffset =>
      Offset(0, -1 * (1 / 2) * localPosition * Constants.staffSpace);

  bool get isUpperLedgerLine => localPosition > 0;

  @override
  String toString() {
    return 'StavePosition(globalPosition: $_globalPosition)';
  }

  StemDirection get defaultStemDirection =>
      localPosition < 0 ? StemDirection.up : StemDirection.down;

  /// Returns the number of upper ledger lines needed for a given note position.
  /// The note position is an integer value representing the distance from the center line.
  /// If the note position is negative, it means the note is below the center line.
  /// If the note position is positive, it means the note is above the center line.
  /// The function calculates the number of upper ledger lines based on the note position.
  /// If the note position is less than 4, it returns 0.
  /// Otherwise, it calculates the number of upper ledger lines by dividing the note position by 2 and subtracting 2.
  /// The result is clamped to a minimum value of 0.
  int get upperLedgerLineNum => max(localPosition ~/ 2 - 2, 0);

  /// Returns the number of lower ledger lines needed for a given note position.
  /// The note position is an integer value representing the distance from the center line.
  /// If the note position is negative, it means the note is below the center line.
  /// If the note position is positive, it means the note is above the center line.
  /// The function calculates the number of lower ledger lines based on the note position.
  /// If the note position is greater than -4, it returns 0.
  /// Otherwise, it calculates the number of lower ledger lines by dividing the absolute value of the note position by 2 and subtracting 2.
  /// The result is clamped to a minimum value of 0.
  int get lowerLedgerLineNum => max(-localPosition ~/ 2 - 2, 0);

  /// TODO ensure that side effects do not occur
  int operator +(StavePosition other) => localPosition + other.localPosition;
}
