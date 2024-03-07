// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:simple_sheet_music/src/objects/draw_line_mixin.dart';
// import 'package:simple_sheet_music/src/objects/glyphs/notes/note_parts/note_stem.dart';
// import 'package:simple_sheet_music/src/objects/glyphs/notes/stem_direction.dart';
// import 'package:simple_sheet_music/src/objects/music_object_interface.dart';

// import 'note.dart';
// import 'notes/note_duration_type.dart';

// class Beam with LineDrawer implements MusicObject {
//   static const beamSpacing = 0.25;
//   static const beamThickness = 0.5;

//   static const beamNum8th = 1;
//   static const beamNum16th = 2;
//   static const beamNum32nd = 3;
//   static const beamNum64th = 4;
//   static const beamNum128th = 5;
//   static bool noteCanBeam(Note note) {
//     return [
//       NoteDurationType.note8th,
//       NoteDurationType.note16th,
//       NoteDurationType.note32nd,
//       NoteDurationType.note64th,
//       NoteDurationType.note128th
//     ].contains(note.noteDurationType);
//   }

//   static bool notesCanBeam(List<Note> notes) {
//     for (final note in notes) {
//       if (!noteCanBeam(note)) {
//         return false;
//       }
//     }
//     return true;
//   }

//   final List<Note> notes;

//   Beam(this.notes) : assert(notesCanBeam(notes));

//   BeamType beamType(Note note) {
//     switch (note.noteDurationType) {
//       case NoteDurationType.note8th:
//         return BeamType.beam8th;
//       case NoteDurationType.note16th:
//         return BeamType.beam16th;
//       case NoteDurationType.note32nd:
//         return BeamType.beam32nd;
//       case NoteDurationType.note64th:
//         return BeamType.beam64th;
//       case NoteDurationType.note128th:
//         return BeamType.beam128th;
//       default:
//         throw 'Invalid beamType';
//     }
//   }

//   List<double> beamInitRelativeXs(Note note) {
//     final beamInitRelativeX =
//         note.stemTipOffset.dx - NoteStem.stemThickness / 2;
//     return List.generate(
//         _getBeamNum(note.noteDurationType), (_) => beamInitRelativeX);
//   }

//   List<double> beamInitRelativeYs(Note note) {
//     if (_stemDirection == StemDirection.down) {
//       return List.generate(
//           _getBeamNum(note.noteDurationType),
//           (index) =>
//               note.stemTipOffset.dy -
//               beamSpacing * index -
//               beamThickness * index);
//     }
//     return List.generate(
//         _getBeamNum(note.noteDurationType),
//         (index) =>
//             note.stemTipOffset.dy +
//             beamSpacing * index +
//             beamThickness * index);
//   }

//   List<Offset> beamInitRelativeOffsets(Note note) {
//     final offsets = <Offset>[];
//     for (int i = 0; i < beamInitRelativeXs(note).length; i++) {
//       final x = beamInitRelativeXs(note)[i];
//       final y = beamInitRelativeYs(note)[i];
//       offsets.add(Offset(x, y));
//     }
//     return offsets;
//   }

//   List<double> beamEndRelativeXs(Note note) {
//     final beamEndRelativeX = note.stemTipOffset.dx + NoteStem.stemThickness / 2;
//     return List.generate(
//         _getBeamNum(note.noteDurationType), (_) => beamEndRelativeX);
//   }

//   List<double> beamEndRelativeYs(Note note) {
//     if (_stemDirection == StemDirection.down) {
//       return List.generate(
//           _getBeamNum(note.noteDurationType),
//           (index) =>
//               note.stemTipOffset.dy -
//               beamSpacing * index -
//               beamThickness * index);
//     }
//     return List.generate(
//         _getBeamNum(note.noteDurationType),
//         (index) =>
//             note.stemTipOffset.dy +
//             beamSpacing * index +
//             beamThickness * index);
//   }

//   List<Offset> beamEndRelativeOffsets(Note note) {
//     final offsets = <Offset>[];
//     for (int i = 0; i < beamEndRelativeXs(note).length; i++) {
//       final x = beamEndRelativeXs(note)[i];
//       final y = beamEndRelativeYs(note)[i];
//       offsets.add(Offset(x, y));
//     }
//     return offsets;
//   }

//   List<Note> get beamedNotes =>
//       notes.map((e) => e.toBeamNote(_stemDirection, beamY)).toList();

//   @override
//   Rect get bbox => Rect.fromLTRB(leftX, upperY, width, lowerY);
//   double get leftX => beamedNotes.first.leftX;

//   double get upperY {
//     return beamedNotes.map((e) => e.upperY).reduce(max);
//   }

//   double get lowerY {
//     return notes.map((e) => e.lowerY).reduce(min);
//   }

//   double get width => notes
//       .map((e) => e.rightX - e.leftX)
//       .reduce((value, element) => value + element);

//   int get _positionsSum =>
//       notes.map((e) => e.position).reduce((value, element) => value + element);

//   StemDirection get _stemDirection =>
//       _positionsSum >= 0 ? StemDirection.down : StemDirection.up;

//   int _getBeamNum(NoteDurationType noteDurationType) {
//     switch (noteDurationType) {
//       case NoteDurationType.note8th:
//         return beamNum8th;
//       case NoteDurationType.note16th:
//         return beamNum16th;
//       case NoteDurationType.note32nd:
//         return beamNum32nd;
//       case NoteDurationType.note64th:
//         return beamNum64th;
//       case NoteDurationType.note128th:
//         return beamNum128th;
//       default:
//         return 0;
//     }
//   }

//   List<int> get beamNums =>
//       notes.map((e) => _getBeamNum(e.noteDurationType)).toList();
//   int get maxBeamNum =>
//       notes.map((e) => _getBeamNum(e.noteDurationType)).reduce(max);

//   Note get _maxPositionNote =>
//       notes.firstWhere((element) => element.position == _maxPosition);
//   Note get _minPositionNote =>
//       notes.firstWhere((element) => element.position == _minPosition);
//   int get _maxPosition => notes.map((e) => e.position).reduce(max);
//   int get _minPosition => notes.map((e) => e.position).reduce(min);

//   double get beamY {
//     if (_stemDirection == StemDirection.down) {
//       return _minPositionNote.stemDownRootY + maxStemLength;
//     }
//     return _maxPositionNote.stemUpRootY - maxStemLength;
//   }

//   double get maxStemLength =>
//       NoteStem.minStemLength +
//       maxBeamNum * beamThickness +
//       maxBeamNum * beamSpacing;

//   bool isFirstNote(Note note) => note == beamedNotes.first;
//   bool isLastNote(Note note) => note == beamedNotes.last;
//   double distanceBetweenNoteStem(Note noteA, Note noteB) =>
//       noteA.width - noteA.stemRootX + noteB.stemRootX;

//   @override
//   void render(Canvas canvas, Size size, Offset offset) {
//     double currentX = 0.0;
//     for (int i = 0; i < beamedNotes.length - 1; i++) {
//       final currentNote = beamedNotes[i];
//       final nextNote = beamedNotes[i + 1];

//       if (i == 0) {
//         for (final relativeOffset in beamInitRelativeOffsets(currentNote)) {
//           final beamInitOffset = relativeOffset + offset + Offset(currentX, 0);
//           final beamEndOffset = relativeOffset +
//               Offset(distanceBetweenNoteStem(currentNote, nextNote) / 2, 0) +
//               offset +
//               Offset(currentX, 0) +
//               const Offset(NoteStem.stemThickness / 2, 0);
//           drawLine(canvas, beamInitOffset, beamEndOffset, beamThickness,
//               color: Colors.red);
//         }
//       } else {
//         for (final endOffset in beamEndRelativeOffsets(currentNote)) {
//           final beamInitOffset = endOffset +
//               offset +
//               Offset(-distanceBetweenNoteStem(currentNote, nextNote) / 2, 0) +
//               Offset(currentX, 0) -
//               const Offset(NoteStem.stemThickness / 2, 0);
//           final beamEndOffset = endOffset + offset + Offset(currentX, 0);
//           drawLine(canvas, beamInitOffset, beamEndOffset, beamThickness,
//               color: Colors.red);
//         }
//       }

//       currentNote.render(canvas, size, offset + Offset(currentX, 0));
//       currentX += currentNote.width;
//     }
//     beamedNotes.last.render(canvas, size, offset + Offset(currentX, 0));
//   }
// }

// enum BeamType {
//   beam8th,
//   beam16th,
//   beam32nd,
//   beam64th,
//   beam128th,
// }
