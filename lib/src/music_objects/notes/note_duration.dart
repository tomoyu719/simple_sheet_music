import 'package:simple_sheet_music/src/music_objects/notes/noteflag_type.dart';
import 'package:simple_sheet_music/src/music_objects/notes/notehead_type.dart';

/// Enum representing the duration of a musical note.
enum NoteDuration {
  /// Whole note duration.
  whole(hasStem: false, hasFlag: false),

  /// Half note duration.
  half(hasFlag: false),

  /// Quarter note duration.
  quarter(hasFlag: false),

  /// Eighth note duration.
  eighth,

  /// Sixteenth note duration.
  sixteenth,

  /// Thirty-second note duration.
  thirtySecond,

  /// Sixty-fourth note duration.
  sixtyFourth,

  /// Hundred twenty-eighth note duration.
  hundredsTwentyEighth;

  /// Constructs a NoteDuration with the given parameters.
  const NoteDuration({this.hasStem = true, this.hasFlag = true});

  /// Whether the note duration has a stem.
  final bool hasStem;

  /// Whether the note duration has a flag.
  final bool hasFlag;

  /// Returns the corresponding NoteHeadType for the note duration.
  NoteHeadType get noteHeadType {
    switch (this) {
      case NoteDuration.whole:
        return NoteHeadType.whole;
      case NoteDuration.half:
        return NoteHeadType.half;
      case NoteDuration.quarter:
      case NoteDuration.eighth:
      case NoteDuration.sixteenth:
      case NoteDuration.thirtySecond:
      case NoteDuration.sixtyFourth:
      case NoteDuration.hundredsTwentyEighth:
        return NoteHeadType.black;
    }
  }

  /// Returns the corresponding NoteFlagType for the note duration.
  NoteFlagType? get noteFlagType {
    switch (this) {
      case NoteDuration.whole:
      case NoteDuration.half:
      case NoteDuration.quarter:
        return null;
      case NoteDuration.eighth:
        return NoteFlagType.flag8th;
      case NoteDuration.sixteenth:
        return NoteFlagType.flag16th;
      case NoteDuration.thirtySecond:
        return NoteFlagType.flag32nd;
      case NoteDuration.sixtyFourth:
        return NoteFlagType.flag64th;
      case NoteDuration.hundredsTwentyEighth:
        return NoteFlagType.flag128th;
    }
  }
}
