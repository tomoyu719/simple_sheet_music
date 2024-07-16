import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/constants.dart';
import 'package:simple_sheet_music/src/extension/list_extension.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_metrics.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';
import 'package:simple_sheet_music/src/music_objects/notes/chord_note/accidental_metrics.dart';
import 'package:simple_sheet_music/src/music_objects/notes/chord_note/chord_note_part.dart';
import 'package:simple_sheet_music/src/music_objects/notes/legerline.dart';
import 'package:simple_sheet_music/src/music_objects/notes/note_duration.dart';
import 'package:simple_sheet_music/src/music_objects/notes/note_pitch.dart';
import 'package:simple_sheet_music/src/music_objects/notes/noteflag_type.dart';
import 'package:simple_sheet_music/src/music_objects/notes/notehead_type.dart';
import 'package:simple_sheet_music/src/music_objects/notes/positions.dart';
import 'package:simple_sheet_music/src/music_objects/notes/stem_direction.dart';
import 'package:simple_sheet_music/src/musical_context.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

/// Represents a chord note in sheet music.
class ChordNote implements MusicalSymbol {
  const ChordNote(
    this.noteParts, {
    this.noteDuration = NoteDuration.quarter,
    this.margin = const EdgeInsets.all(10),
    this.color = Colors.black,
    this.stemDirection,
  });

  @override
  final EdgeInsets margin;

  /// The stem direction of the chord note.
  final StemDirection? stemDirection;

  /// The list of chord note parts that make up the chord note.
  final List<ChordNotePart> noteParts;

  @override
  final Color color;

  /// The duration of the chord note.
  final NoteDuration noteDuration;

  /// The type of note head for the chord note.
  NoteHeadType get noteHeadType => noteDuration.noteHeadType;

  /// The key used to retrieve the path for the note head.
  String get noteHeadPathKey => noteHeadType.pathKey;

  @override
  MusicalSymbolMetrics setContext(
    MusicalContext context,
    GlyphMetadata metadata,
    GlyphPaths paths,
  ) =>
      ChordNoteMetrics(
        this,
        context,
        metadata,
        paths,
      );
}

/// Represents the metrics (size and position) of a [ChordNote].
class ChordNoteMetrics implements MusicalSymbolMetrics {
  const ChordNoteMetrics(
    this.note,
    this.context,
    this.metadata,
    this.path,
  );

  final MusicalContext context;
  final GlyphMetadata metadata;
  final GlyphPaths path;
  final ChordNote note;

  List<ChordNotePart> get _noteParts => note.noteParts;

  List<ChordNoteHeadMetrics> get _noteHeads => _noteParts
      .map((part) => ChordNoteHeadMetrics(_noteHeadPath(part), part))
      .toList();

  /// thickness of the leger lines.
  double get legerLineThickness => metadata.legerLineThickness;

  /// extension of the leger lines.
  double get legerLineExtension => metadata.legerLineExtension;

  /// path of the note head for a specific [ChordNotePart].
  Path _noteHeadPath(ChordNotePart part) {
    final noteHeadLeftX = _getNoteHeadLeftX(part);
    return _noteHeadOriginPath
        .shift(Offset(noteHeadLeftX, 0) + _positionOffset(part));
  }

  /// list of [ChordNotePart]s that have accidental note heads.
  List<ChordNotePart> get _hasAccidentalNoteHeads =>
      _noteParts.where((e) => e.accidental != null).toList();

  /// the metrics for the accidental of a specific [ChordNotePart].
  AccidentalMetrics _accidentalMetrics(ChordNotePart note, double offsetX) =>
      AccidentalMetrics(
        _getNotePosition(note).localPosition,
        _getPath(note.accidental!.pathKey),
        offsetX,
      );

  /// the list of accidental metrics for all the accidental note heads.
  List<AccidentalMetrics> get accidentalMetricses {
    final metricses = <AccidentalMetrics>[];
    var offsetX = 0.0;
    for (final note in _hasAccidentalNoteHeads) {
      final accidental = _accidentalMetrics(note, offsetX);
      metricses.add(accidental);
      offsetX += accidental.width;
    }
    return metricses;
  }

  /// the list of bounding boxes for all the accidental note heads.
  List<Rect> get _accidentalBboxes =>
      accidentalMetricses.map((e) => e.bbox).toList();

  /// get path from a path key.
  Path _getPath(String pathKey) => path.parsePath(pathKey);

  /// Gets the position of a note on the stave.
  StavePosition _getNotePosition(ChordNotePart note) =>
      StavePosition(note.pitch, _clefType);

  /// clefType of this chord note.
  ClefType get _clefType => context.clefType;

  /// Checks if the chord note has any accidental.
  bool get _hasAccidental => _noteParts.any((e) => e.accidental != null);

  /// Gets the bounding box of the accidentals.
  Rect get _accidentalsBbox {
    if (!_hasAccidental) {
      return Rect.zero;
    }
    final bboxes = _accidentalBboxes;
    final l = bboxes.map((e) => e.left).min;
    final t = bboxes.map((e) => e.top).min;
    final r = bboxes.map((e) => e.right).max;
    final b = bboxes.map((e) => e.bottom).max;
    return Rect.fromLTRB(l, t, r, b);
  }

  /// Gets the sum of the widths of the accidentals.
  double get _accidentalsWidthSum => _accidentalsBbox.width;

  /// Gets the left x-coordinate of the left note head.
  double get _leftNoteHeadLeftX => _accidentalsBbox.right;

  /// Gets the left x-coordinate of the right note head.
  double get _rightNoteHeadLeftX =>
      _leftNoteHeadLeftX + _noteHeadWidth - stemThickness;

  /// Gets the original path of the note head.
  Path get _noteHeadOriginPath => _getPath(_noteHeadPathKey);

  /// Gets the width of the note head.
  double get _noteHeadWidth => _noteHeadOriginPath.getBounds().width;

  @override
  double get lowerHeight => _bbox.bottom;

  /// Gets the bounding box of the chord note.
  Rect get _bbox => Rect.fromLTRB(_left, _top, _right, _bottom);

  /// Gets the left coordinate of the bounding box.
  double get _left => [noteHeadsBbox.left, _accidentalsBbox.left].min;

  /// Gets the top coordinate of the bounding box.
  double get _top => [
        noteHeadsBbox.top,
        (stemTipOffset?.dy ?? double.infinity),
        (_flagBbox?.top ?? double.infinity),
        _accidentalsBbox.top,
      ].min;

  /// Gets the right coordinate of the bounding box.
  double get _right => [
        noteHeadsBbox.right,
        (_flagBbox?.right ?? double.negativeInfinity),
        _accidentalsBbox.right,
      ].max;

  /// Gets the bottom coordinate of the bounding box.
  double get _bottom => [
        noteHeadsBbox.bottom,
        (stemTipOffset?.dy ?? double.negativeInfinity),
        (_flagBbox?.bottom ?? double.negativeInfinity),
        _accidentalsBbox.bottom,
      ].max;

  @override
  EdgeInsets get margin => note.margin;

  @override
  double get upperHeight => -_bbox.top;

  @override
  double get width => _accidentalsWidthSum + _bbox.width;

  /// Gets the list of bounding boxes for all the note heads.
  List<Rect> get _noteHeadsBboxes =>
      _noteHeads.map((e) => e.noteHeadRect).toList();

  /// Gets the bounding box that encompasses all the note heads.
  Rect get noteHeadsBbox => _noteHeadsBboxes.fold(
        _noteHeadsBboxes.first,
        (previousValue, element) => previousValue.expandToInclude(element),
      );

  /// Gets the path key of the note head.
  String get _noteHeadPathKey => _noteHeadType.pathKey;

  /// Gets the left x-coordinate of the note head for a specific [ChordNotePart].
  double _getNoteHeadLeftX(ChordNotePart note) =>
      (_hasNoteHeadBelowOne(note) ? _rightNoteHeadLeftX : _leftNoteHeadLeftX);

  /// Checks if the position difference with the note below is 1.
  bool _hasNoteHeadBelowOne(ChordNotePart noteHead) =>
      _otherPitches(noteHead.pitch).contains(noteHead.pitch.down);

  /// Returns a list of [Pitch] objects that are not equal to the given [pitch].
  List<Pitch> _otherPitches(Pitch pitch) =>
      _noteParts.map((e) => e.pitch).where((e) => e != pitch).toList();

  /// Gets the sum of the local positions of the note parts.
  int get _notePositionsSum => _noteParts
      .map((e) => _getNotePosition(e).localPosition)
      .fold(0, (a, b) => a + b);

  /// Gets the offset of the stem root for the highest note.
  Offset get _uppestNoteStemRootOffset => _noteStemRootOffset(_uppestNote);

  /// Gets the offset of the stem root for the lowest note.
  Offset get _lowestNoteStemRootOffset => _noteStemRootOffset(_lowestNote);

  /// Gets the minimum length of the stem.
  double get _minStemLength => metadata.minStemLength;

  double get _tipNoteStemRootToStaffCenterDist => _isStemUp
      ? _uppestNoteStemRootOffset.dy
      : -1 * _lowestNoteStemRootOffset.dy;

  /// Checks if the stem is centered.
  bool get _isStemCentered =>
      _tipNoteStemRootToStaffCenterDist > _minStemLength;

  /// Gets the length of the stem.
  double get _stemLength =>
      _isStemCentered ? _tipNoteStemRootToStaffCenterDist : _minStemLength;

  /// Gets the thickness of the stem.
  double get stemThickness => metadata.stemThickness;

  /// Gets the initial x-coordinate of the note head.
  double get _noteHeadInitialX => noteHeadsBbox.left;

  /// Gets the offset of the stem root.
  Offset get stemRootOffset =>
      _isStemUp ? _lowestNoteStemRootOffset : _uppestNoteStemRootOffset;

  /// Gets the offset of the tip note root.
  Offset get _tipNoteRootOffset =>
      _isStemUp ? _uppestNoteStemRootOffset : _lowestNoteStemRootOffset;

  /// Calculates the offset of the stem root for a specific [ChordNoteHeadMetrics].
  Offset _noteStemRootOffset(ChordNoteHeadMetrics noteHead) =>
      Offset(_noteHeadInitialX, 0) +
      metadata.stemRootOffset(_noteHeadType.metadataKey, isStemUp: _isStemUp) +
      _stemThicknessOffset +
      _positionOffset(noteHead.part);

  /// Gets the offset for adjusting the stem thickness.
  Offset get _stemThicknessOffset =>
      Offset(_isStemUp ? -stemThickness / 2 : stemThickness / 2, 0);

  /// Gets the offset of the stem tip.
  Offset? get stemTipOffset {
    if (!hasStem) {
      return null;
    }
    if (hasFlag) {
      return _flagStemTipOffset! + Offset(stemThickness / 2, 0);
    }
    if (_isStemCentered) {
      return Offset(stemRootOffset.dx, 0);
    }
    return _tipNoteRootOffset +
        Offset(0, _isStemUp ? -_stemLength : _stemLength);
  }

  /// Gets the offset of the flag.
  Offset get _flagOffset {
    if (_isStemCentered) {
      return Offset(
        stemRootOffset.dx - stemThickness / 2,
        -(_isStemUp ? _flagBboxMetrics!.top : _flagBboxMetrics!.bottom),
      );
    }
    return _tipNoteRootOffset +
        Offset(0, _isStemUp ? -_stemLength : _stemLength);
  }

  /// Calculates the position offset for a specific [ChordNotePart].
  Offset _positionOffset(ChordNotePart note) {
    final position = _getNotePosition(note).localPosition;
    return Offset(0, -1 * (1 / 2) * position * Constants.staffSpace);
  }

  /// Gets the lowest note among the note heads.
  ChordNoteHeadMetrics get _lowestNote {
    var lowestNote = _noteHeads.first;
    for (final note in _noteHeads) {
      if (note.pitch <= lowestNote.pitch) {
        lowestNote = note;
      }
    }
    return lowestNote;
  }

  /// Gets the highest note among the note heads.
  ChordNoteHeadMetrics get _uppestNote {
    var uppest = _noteHeads.first;
    for (final note in _noteHeads) {
      if (note.pitch >= uppest.pitch) {
        uppest = note;
      }
    }
    return uppest;
  }

  /// Gets the stave position of the highest note.
  StavePosition get uppestNotePosition => _getNotePosition(_uppestNote.part);

  /// Gets the stave position of the lowest note.
  StavePosition get lowestNotePosition => _getNotePosition(_lowestNote.part);

  /// Checks if the chord note has a stem.
  bool get hasStem => note.noteDuration.hasStem;

  /// Checks if the stem direction is up.
  bool get _isStemUp => note.stemDirection?.isUp ?? _defaultStemDirection.isUp;

  /// Gets the default stem direction based on the note positions.
  StemDirection get _defaultStemDirection =>
      _notePositionsSum < 0 ? StemDirection.up : StemDirection.down;

  /// Gets the type of note head used in the chord note.
  NoteHeadType get _noteHeadType => note.noteHeadType;

  /// Checks if the chord note has a flag.
  bool get hasFlag => note.noteDuration.hasFlag;

  /// Gets the type of note flag used in the chord note.
  NoteFlagType? get _noteFlagType => note.noteDuration.noteFlagType;

  /// Gets the metadata key for the flag.
  String? get _flagMetadataKey {
    if (!hasFlag) {
      return null;
    }
    return _isStemUp
        ? _noteFlagType!.upMetadataKey
        : _noteFlagType!.downMetadataKey;
  }

  /// Gets the path key for the flag.
  String? get _flagPathKey {
    if (!hasFlag) {
      return null;
    }
    return _isStemUp ? _noteFlagType!.upPathKey : _noteFlagType!.downPathKey;
  }

  /// Gets the offset of the stem tip for the flag.
  Offset? get _flagStemTipOffset {
    if (!hasFlag) {
      return null;
    }
    return metadata.flagRootOffset(_flagMetadataKey!, isStemUp: _isStemUp) +
        _flagOffset;
  }

  /// Gets the path of the flag on the y-coordinate 0.
  Path? get _flagPathOnY0 {
    if (!hasFlag) {
      return null;
    }
    return path.parsePath(_flagPathKey!);
  }

  /// Gets the bounding box metrics of the flag.
  Rect? get _flagBboxMetrics {
    if (!hasFlag) {
      return null;
    }
    return _flagPathOnY0!.getBounds();
  }

  /// Gets the path of the flag.
  Path? get flagPath {
    if (!hasFlag) {
      return null;
    }
    return _flagPathOnY0!.shift(_flagOffset);
  }

  /// Gets the bounding box of the flag.
  Rect? get _flagBbox => flagPath?.getBounds();

  /// Gets the list of paths for all the note heads.
  List<Path> get noteHeadsPaths =>
      _noteHeads.map((e) => e.noteHeadPath).toList();

  @override
  MusicalSymbolRenderer renderer(
    SheetMusicLayout layout, {
    required double staffLineCenterY,
    required double symbolX,
  }) =>
      ChordNoteRenderer(
        this,
        layout,
        staffLineCenterY: staffLineCenterY,
        symbolX: symbolX,
      );
}

class ChordNoteRenderer implements MusicalSymbolRenderer {
  const ChordNoteRenderer(
    this.note,
    this.layout, {
    required this.staffLineCenterY,
    required this.symbolX,
  });
  final double staffLineCenterY;
  final double symbolX;
  final ChordNoteMetrics note;
  final SheetMusicLayout layout;

  @override
  bool isHit(Offset position) => _renderArea.contains(position);

  @override
  void render(Canvas canvas) {
    _renderNoteHead(canvas);
    _renderFlag(canvas);
    _renderAccidentals(canvas);
    _renderStem(canvas);
    _renderLegerLine(canvas);
  }

  void _renderNoteHead(Canvas canvas) {
    for (final path in note.noteHeadsPaths) {
      canvas.drawPath(
        path.shift(_renderOffset),
        Paint()
          ..color = note.note.color
          ..strokeWidth = 2,
      );
    }
  }

  Rect get _renderArea => throw UnimplementedError();

  void _renderAccidentals(Canvas canvas) {
    for (final accidental in note.accidentalMetricses) {
      canvas.drawPath(
        accidental.path.shift(_renderOffset),
        Paint()
          ..color = note.note.color
          ..strokeWidth = 2,
      );
    }
  }

  void _renderStem(Canvas canvas) {
    if (!note.hasStem) {
      return;
    }
    canvas.drawLine(
      note.stemRootOffset + _renderOffset,
      note.stemTipOffset! + _renderOffset,
      Paint()
        ..color = note.note.color
        ..strokeWidth = note.stemThickness,
    );
  }

  void _renderFlag(Canvas canvas) {
    if (!note.hasFlag) {
      return;
    }
    canvas.drawPath(
      note.flagPath!.shift(_renderOffset),
      Paint()
        ..color = note.note.color
        ..strokeWidth = 2,
    );
  }

  Offset get _renderOffset => Offset(symbolX, staffLineCenterY) + _marginOffset;
  Offset get _marginOffset => Offset(note.margin.left / layout.canvasScale, 0);

  double get _legerLineWidth => note.legerLineExtension * 2 + _noteHeadWidth;

  double get _legerLineThickness => note.legerLineThickness;
  void _renderLegerLine(Canvas canvas) {
    LegerLineRenderer(
      layout.lineColor,
      _uppestNotePosition,
      staffLineCenterY: staffLineCenterY,
      noteCenterX: _noteHeadCenterX,
      legerLineWidth: _legerLineWidth,
      legerLineThickness: _legerLineThickness,
    ).render(canvas);
    LegerLineRenderer(
      layout.lineColor,
      _lowestNotePosition,
      staffLineCenterY: staffLineCenterY,
      noteCenterX: _noteHeadCenterX,
      legerLineWidth: _legerLineWidth,
      legerLineThickness: _legerLineThickness,
    ).render(canvas);
  }

  StavePosition get _uppestNotePosition => note.uppestNotePosition;
  StavePosition get _lowestNotePosition => note.lowestNotePosition;

  double get _noteHeadWidth => _noteHeadRenderArea.width;
  Rect get _noteHeadRenderArea => note.noteHeadsBbox.shift(_renderOffset);
  double get _noteHeadLeftX => _noteHeadRenderArea.left;

  double get _noteHeadCenterX => _noteHeadLeftX + _noteHeadWidth / 2;
}
