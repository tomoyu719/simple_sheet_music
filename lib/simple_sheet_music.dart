/// The `simple_sheet_music` library provides a simple way to display sheet music in a Flutter application.
/// It includes classes for rendering staffs, measures, clefs, notes, and other music objects.
/// The `SimpleSheetMusic` widget is the main entry point for displaying sheet music.
/// It takes a list of `Staff` objects and other optional parameters to customize the appearance of the sheet music.
library simple_sheet_music;

export '/src/font_types.dart' show FontType;
export '/src/measure/measure.dart' show Measure;
export '/src/music_objects/clef/clef.dart' show Clef;
export '/src/music_objects/clef/clef_type.dart' show ClefType;
export '/src/simple_sheet_music.dart' show SimpleSheetMusic;
export 'src/music_objects/key_signature/key_signature.dart' show KeySignature;
export 'src/music_objects/key_signature/keysignature_type.dart'
    show KeySignatureType;
export 'src/music_objects/notes/accidental.dart' show Accidental;
export 'src/music_objects/notes/chord_note/chord_note.dart' show ChordNote;
export 'src/music_objects/notes/chord_note/chord_note_part.dart'
    show ChordNotePart;
export 'src/music_objects/notes/note_duration.dart' show NoteDuration;
export 'src/music_objects/notes/note_pitch.dart' show Pitch;
export 'src/music_objects/notes/single_note/note.dart' show Note;
// export 'src/music_objects/notes/stem_direction.dart' show StemDirection;
export 'src/music_objects/rest/rest.dart' show Rest;
export 'src/music_objects/rest/rest_type.dart' show RestType;
