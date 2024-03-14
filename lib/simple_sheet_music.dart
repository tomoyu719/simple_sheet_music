/// The `simple_sheet_music` library provides a simple way to display sheet music in a Flutter application.
/// It includes classes for rendering staffs, measures, clefs, notes, and other music objects.
/// The `SimpleSheetMusic` widget is the main entry point for displaying sheet music.
/// It takes a list of `Staff` objects and other optional parameters to customize the appearance of the sheet music.

library simple_sheet_music;

export '/src/measure/measure.dart' show Measure;
export '/src/music_objects/clef/clef_type.dart';
export '/src/music_objects/clef/clef.dart' show Clef;
export 'src/music_objects/note/note.dart' show Note;
export '/src/music_objects/interface/music_object_style.dart';
export 'src/staff/staff.dart';
export 'src/music_objects/note/parts/fingering.dart' show Fingering;
export '/src/font_types.dart';
export '/src/simple_sheet_music.dart'
    show SimpleSheetMusic, OnTapMusicObjectCallback;
export 'src/music_objects/note/note_duration.dart';
export 'src/music_objects/note/note_pitch.dart';
export 'src/music_objects/note/accidentals/accidental.dart' show Accidental;
export 'src/music_objects/rest/rest.dart' show Rest;
export 'src/music_objects/rest/rest_type.dart';
export 'src/music_objects/key_signature/key_signature.dart'
    show KeySignature, KeySignatureType;
