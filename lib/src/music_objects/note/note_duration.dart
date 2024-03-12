import 'package:simple_sheet_music/src/music_objects/notes/parts/noteflag_type.dart';
import 'package:simple_sheet_music/src/music_objects/notes/parts/notehead_type.dart';

enum NoteDuration {
  whole(128),
  half(64),
  quarter(32),
  eighth(16),
  sixteenth(8),
  thirtySecond(4),
  sixtyFourth(2),
  oneHundredsTwentyEighth(1);

  const NoteDuration(this.time);
  final int time;
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
      case NoteDuration.oneHundredsTwentyEighth:
        return NoteHeadType.black;
    }
  }

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
        return NoteFlagType.flag32th;
      case NoteDuration.sixtyFourth:
        return NoteFlagType.flag64th;
      case NoteDuration.oneHundredsTwentyEighth:
        return NoteFlagType.flag128th;
    }
  }
}
