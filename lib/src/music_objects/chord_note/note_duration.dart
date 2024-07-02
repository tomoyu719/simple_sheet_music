import 'package:simple_sheet_music/src/music_objects/note/parts/noteflag_type.dart';
import 'package:simple_sheet_music/src/music_objects/note/parts/notehead_type.dart';

enum NoteDuration {
  whole(hasStem: false, hasFlag: false),
  half(hasFlag: false),
  quarter(hasFlag: false),
  eighth,
  sixteenth,
  thirtySecond,
  sixtyFourth,
  hundredsTwentyEighth;

  const NoteDuration({this.hasStem = true, this.hasFlag = true});

  final bool hasStem;
  final bool hasFlag;
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
