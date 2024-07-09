import 'dart:ui';

import 'package:simple_sheet_music/src/music_objects/notes/accidental.dart';
import 'package:simple_sheet_music/src/music_objects/notes/note_pitch.dart';

/// Represents a part of a chord note, including the pitch and optional accidental.
class ChordNotePart {
  const ChordNotePart(this.pitch, {this.accidental});

  /// The pitch of the chord note part.
  final Pitch pitch;

  /// The accidental of the chord note part, if any.
  final Accidental? accidental;
}

/// Represents the metrics of a chord note head, including the note head path and the associated chord note part.
class ChordNoteHeadMetrics {
  const ChordNoteHeadMetrics(this.noteHeadPath, this.part);

  /// The chord note part associated with the chord note head metrics.
  final ChordNotePart part;

  /// The path of the note head.
  final Path noteHeadPath;

  /// The bounding rectangle of the note head.
  Rect get noteHeadRect => noteHeadPath.getBounds();

  /// The pitch of the chord note part.
  Pitch get pitch => part.pitch;
}
