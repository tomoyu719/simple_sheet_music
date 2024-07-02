import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/constants.dart';
import 'package:simple_sheet_music/src/extension/list_extension.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_y0.dart';
import 'package:simple_sheet_music/src/music_objects/note/accidental.dart';

import 'package:simple_sheet_music/src/music_objects/note/legerline/legerline.dart';
import 'package:simple_sheet_music/src/music_objects/note/note_duration.dart';
import 'package:simple_sheet_music/src/music_objects/note/note_pitch.dart';
import 'package:simple_sheet_music/src/music_objects/note/parts/noteflag_type.dart';
import 'package:simple_sheet_music/src/music_objects/note/parts/notehead_type.dart';
import 'package:simple_sheet_music/src/music_objects/note/positions.dart';
import 'package:simple_sheet_music/src/music_objects/note/stem_direction.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

class Note implements MusicalSymbol {
  const Note({
    required this.pitch,
    required this.noteDuration,
    this.accidental,
    this.margin = const EdgeInsets.all(10),
    this.color = Colors.black,
    this.stemDirection,
  });
  StavePosition get stavePosition => StavePosition(pitch);
  @override
  final EdgeInsets margin;
  final StemDirection? stemDirection;

  @override
  final Color color;
  final Pitch pitch;
  final NoteDuration noteDuration;
  final Accidental? accidental;
  NoteHeadType get noteHeadType => noteDuration.noteHeadType;

  @override
  MusicalSymbolOnY0 setOnY0(SheetMusicLayout layout) {
    return NoteOnY0(layout, this);
  }
}

class NoteOnY0 implements MusicalSymbolOnY0 {
  const NoteOnY0(this.layout, this.note);

  final Note note;
  final SheetMusicLayout layout;
  @override
  double get lowerHeight => bbox.bottom;

  @override
  MusicalSymbol get musicalSymbol => note;

  double get noteHeadWidth => noteHeadBbox.width;

  Rect get bbox => Rect.fromLTRB(left, top, right, bottom);
  double get left =>
      [noteHeadBbox.left, (accidentalBbox?.left ?? double.infinity)].min;
  double get top => [
        noteHeadBbox.top,
        stemTipOffset.dy,
        (flagBbox?.top ?? double.infinity),
        (accidentalBbox?.top ?? double.infinity),
      ].min;
  double get right => [
        noteHeadBbox.right,
        (flagBbox?.right ?? double.negativeInfinity),
        (accidentalBbox?.right ?? double.negativeInfinity),
      ].max;
  double get bottom => [
        noteHeadBbox.bottom,
        stemTipOffset.dy,
        (flagBbox?.bottom ?? double.negativeInfinity),
        (accidentalBbox?.bottom ?? double.negativeInfinity),
      ].max;

  EdgeInsets get margin => note.margin;

  Pitch get pitch => note.pitch;

  @override
  MusicalSymbolRenderer renderer({
    required double staffLineCenterY,
    required double symbolX,
  }) =>
      NoteRenderer(
        this,
        staffLineCenterY: staffLineCenterY,
        symbolX: symbolX,
      );

  @override
  double get upperHeight => -bbox.top;

  @override
  double get width => bbox.width;

  Rect get noteHeadBbox => noteHeadPath.getBounds();

  Offset get defaultOffset => Offset.zero;
  Path get noteHeadPath => layout
      .getPath(note.noteHeadType.pathKey)
      .shift(defaultOffset + positionOffset + Offset(accidentalWidth, 0));
  double get noteHeadLeftX => noteHeadBbox.left;
  double get accidentalWidth => accidentalBbox?.width ?? 0;
  Rect? get accidentalBbox {
    if (!hasAccidental) {
      return null;
    }
    return accidentalPath!.getBounds();
  }

  /// Returns the position offset of the note.
  ///
  /// The position offset is calculated based on the note's stave position
  /// and the clef type. It is used to determine the vertical position of
  /// the note on the staff.
  /// The reason for -1 is Y-axis of Flutter's Canvas Api is inverted. And
  /// the reason for -1/2 is moving 2 positions means moving 1Staff Space.
  Offset get positionOffset {
    final offsetHeight = -1 * staffSpace / 2 * notePosition;
    return Offset(0, offsetHeight);
  }

  Accidental? get accidental => note.accidental;
  bool get hasAccidental => accidental != null;
  Path? get accidentalPath {
    if (!hasAccidental) {
      return null;
    }
    return layout
        .getPath(accidental!.pathKey)
        .shift(defaultOffset + positionOffset);
  }

  int get notePosition => note.stavePosition.localPosition(clefType);

  ClefType get clefType => layout.clefType(this);
  double get minStemLength => layout.minStemLength;
  double get stemRootToStaffCenterDist => stemRootOffset.dy.abs();
  bool get isStemCentered => stemRootToStaffCenterDist > minStemLength;
  double get stemLength =>
      isStemCentered ? stemRootToStaffCenterDist : minStemLength;
  double get stemThickness => layout.stemThickness;
  double get noteHeadInitialX => noteHeadBbox.left;
  Offset get stemRootOffset =>
      Offset(noteHeadInitialX, 0) +
      layout.stemRootOffset(noteHeadType.metadataKey, isStemUp: isStemUp) +
      stemThicknessOffset +
      positionOffset;
  Offset get stemThicknessOffset =>
      Offset(isStemUp ? -stemThickness / 2 : stemThickness / 2, 0);
  Offset get stemTipOffset {
    if (hasFlag) {
      return flagStemOffset! + Offset(stemThickness / 2, 0);
    }
    if (isStemCentered) {
      return Offset(stemRootOffset.dx, 0);
    }
    return stemRootOffset + Offset(0, isStemUp ? -stemLength : stemLength);
  }

  Offset get flagOffset {
    if (isStemCentered) {
      return Offset(stemRootOffset.dx - stemThickness / 2,
          -(isStemUp ? flagBboxOnY0!.top : flagBboxOnY0!.bottom));
    }
    return stemRootOffset + Offset(0, isStemUp ? -stemLength : stemLength);
  }

  bool get hasStem => note.noteDuration.hasStem;
  bool get isStemUp => note.stemDirection?.isUp ?? defaultStemDirection.isUp;
  StemDirection get defaultStemDirection =>
      notePosition < 0 ? StemDirection.up : StemDirection.down;
  NoteHeadType get noteHeadType => note.noteHeadType;
  bool get hasFlag => note.noteDuration.hasFlag;
  NoteFlagType? get noteFlagType => note.noteDuration.noteFlagType;
  String? get flagMetadataKey {
    if (!hasFlag) {
      return null;
    }
    return isStemUp
        ? noteFlagType!.upMetadataKey
        : noteFlagType!.downMetadataKey;
  }

  String? get flagPathKey {
    if (!hasFlag) {
      return null;
    }
    return isStemUp ? noteFlagType!.upPathKey : noteFlagType!.downPathKey;
  }

  Offset? get flagStemOffset {
    if (!hasFlag) {
      return null;
    }
    return layout.flagStemOffset(flagMetadataKey!, isStemUp: isStemUp) +
        flagOffset;
  }

  Path? get flagPathOnY0 {
    if (!hasFlag) {
      return null;
    }
    return layout.getPath(flagPathKey!);
  }

  Rect? get flagBboxOnY0 {
    if (!hasFlag) {
      return null;
    }
    return flagPathOnY0!.getBounds();
  }

  Path? get flagPath {
    if (!hasFlag) {
      return null;
    }
    return flagPathOnY0!.shift(flagOffset);
  }

  Rect? get flagBbox => flagPath?.getBounds();
}

class NoteRenderer implements MusicalSymbolRenderer {
  const NoteRenderer(
    this.note, {
    required this.staffLineCenterY,
    required this.symbolX,
  });
  final double staffLineCenterY;
  final double symbolX;
  final NoteOnY0 note;

  @override
  bool isHit(Offset position) => renderArea.contains(position);

  @override
  void render(Canvas canvas, Size size) {
    _renderNoteHead(canvas);
    _renderFlag(canvas);
    _renderAccidental(canvas);
    _renderStem(canvas);
    _renderLegerLine(canvas, size);
    canvas.drawRect(renderArea, Paint()..color = Colors.red.withOpacity(0.5));
  }

  void _renderNoteHead(Canvas canvas) {
    canvas.drawPath(noteHeadRenderPath, Paint()..color = note.note.color);
  }

  void _renderAccidental(Canvas canvas) {
    if (!note.hasAccidental) {
      return;
    }
    canvas.drawPath(
      renderAccidentalPath!,
      Paint()
        ..color = note.note.color
        ..strokeWidth = 2,
    );
  }

  Path? get renderAccidentalPath => note.accidentalPath?.shift(renderOffset);

  void _renderStem(Canvas canvas) {
    if (!note.hasStem) {
      return;
    }
    canvas.drawLine(
      note.stemRootOffset + renderOffset,
      note.stemTipOffset + renderOffset,
      Paint()
        ..color = note.note.color
        ..strokeWidth = note.stemThickness,
    );
  }

  Path get noteHeadRenderPath => note.noteHeadPath.shift(renderOffset);

  double get scale => layout.canvasScale;

  void _renderFlag(Canvas canvas) {
    if (!note.hasFlag) {
      return;
    }
    canvas.drawPath(
      note.flagPath!.shift(renderOffset),
      Paint()
        ..color = note.note.color
        ..strokeWidth = 2,
    );
  }

  // TODO explain why
  Offset get renderOffset => Offset(symbolX, staffLineCenterY) + marginOffset;
  Offset get marginOffset => Offset(note.margin.left / scale, 0);

  @override
  Rect get renderArea => note.bbox.shift(renderOffset);
  double get legerLineWidth => layout.legerLineExtension * 2 + noteHeadWidth;

  double get legerLineThickness => layout.legerLineThickness;
  void _renderLegerLine(Canvas canvas, Size size) => LegerLineRenderer(
        layout.lineColor,
        notePosition,
        staffLineCenterY: staffLineCenterY,
        noteCenterX: noteHeadCenterX,
        legerLineWidth: legerLineWidth,
        legerLineThickness: legerLineThickness,
      ).render(canvas);

  int get notePosition => note.notePosition;
  SheetMusicLayout get layout => note.layout;
  double get noteHeadWidth => note.noteHeadWidth;
  Rect get noteHeadRenderArea => note.noteHeadBbox.shift(renderOffset);
  double get noteHeadCenterY => noteHeadRenderArea.center.dy;
  double get noteHeadLeftX =>
      renderOffset.dx +
      note.noteHeadLeftX +
      (note.hasAccidental ? note.accidentalWidth : 0);
  double get noteHeadCenterX => noteHeadLeftX + note.noteHeadWidth / 2;
  double get legerLineLeftX => noteHeadCenterX - legerLineWidth / 2;
  double get legerLineRightX => legerLineLeftX + legerLineWidth;
}

// class BuiltNote implements BuiltObject {
//   static const minStemLength = 3.5;
//   static const halfPositionHeight = 0.5;

//   final Accidental? accidentalType;
//   final NoteHeadType noteHeadType;
//   final NoteFlagType? noteFlagType;
//   final Fingering? fingering;
//   final StavePosition stavePosition;
//   final Note noteStyle;
//   final EdgeInsets? specifiedMargin;

//   const BuiltNote(this.noteStyle, this.noteHeadType, this.stavePosition,
//       this.specifiedMargin,
//       {this.noteFlagType, this.accidentalType, this.fingering});

//   FingeringRenderer? get _fingeringOnMeasure => fingering != null
//       ? FingeringRenderer(fingering!,
//           noteUpperHeight: _noteUpperHeight,
//           noteHeadCenterX: _noteHead.noteHeadCenterX)
//       : null;

//   EdgeInsets get _defaultMargin =>
//       specifiedMargin ?? EdgeInsets.all(_objectWidth / 4);
//   EdgeInsets get _margin => noteStyle.specifiedMargin ?? _defaultMargin;

//   bool get _hasAccidental => accidentalType != null;

//   AccidentalRenderer? get _accidental => _hasAccidental
//       ? AccidentalRenderer(accidentalType!, _localPosition)
//       : null;

//   double get _accidentalWidth => _accidental?.width ?? 0;

//   double get _accidentalSpacing => _accidentalWidth / 5;

//   int get _localPosition => stavePosition.localPosition;
//   bool get _isStemUp => _localPosition < 0;

//   bool get _hasStem => noteHeadType.hasStem;

//   NoteHead get _noteHead => NoteHead(
//       noteHeadType, _localPosition, _accidentalWidth + _accidentalSpacing);

//   NoteStem? get _noteStem => _hasStem
//       ? NoteStem(
//           _isStemUp,
//           stemRootOffset: _stemRootOffset,
//           stemTipOffset: _stemTipOffset,
//         )
//       : null;

//   double get _stemX => _isStemUp ? _noteHead.stemUpX : _noteHead.stemDownX;
//   double get _stemRootY =>
//       _isStemUp ? _noteHead.stemUpRootY : _noteHead.stemDownRootY;

//   Offset get _stemRootOffset => Offset(_stemX, _stemRootY);

//   double get _stemTipY {
//     if (_hasFlag) return _noteFlag!.stemTipY;
//     return _isStemUp ? _stemUpTipY : _stemDownTipY;
//   }

//   double get _stemUpTipY =>
//       _isStemTipOnCenter ? 0.0 : _noteHead.stemUpRootY - NoteStem.minStemLength;
//   double get _stemDownTipY => _isStemTipOnCenter
//       ? 0.0
//       : _noteHead.stemDownRootY + NoteStem.minStemLength;

//   Offset get _stemTipOffset => Offset(_stemX, _stemTipY);

//   bool get _hasFlag => noteFlagType != null;

//   NoteFlag? get _noteFlag => _hasFlag
//       ? NoteFlag(_noteHead, noteFlagType!, _isStemUp, _isStemTipOnCenter)
//       : null;

//   bool get _isStemTipOnCenter => _localPosition <= -7 || 7 <= _localPosition;

//   @override
//   MusicalSymbolRenderer placeOnCanvas({
//     required double previousObjectsWidthSum,
//     required double staffLineCenterY,
//   }) {
//     // final helper = ObjectOnCanvasHelper(
//     //   _bboxWithNoMargin,
//     //   Offset(previousObjectsWidthSum, staffLineCenterY),
//     //   _margin,
//     // );
//     throw UnimplementedError();

//     // return NoteRenderer(helper, noteStyle,
//     //     noteHead: _noteHead,
//     //     noteStem: _noteStem,
//     //     noteFlag: _noteFlag,
//     //     accidental: _accidental,
//     //     position: _localPosition,
//     //     fingering: _fingeringOnMeasure);
//   }

//   double get _fingeringHeight => _fingeringOnMeasure?.upperHeight ?? 0.0;

//   double get _noteHeadUpperHeight => _noteHead.upperHeight;
//   double get _noteHeadLowerHeight => _noteHead.lowerHeight;

//   double get _noteFlagUpperHeight => _noteFlag?.upperHeight ?? 0.0;
//   double get _noteFlagLowerHeight => _noteFlag?.lowerHeight ?? 0.0;

//   double get _noteStemUpperHeight => _noteStem?.upperHeight ?? 0.0;
//   double get _noteStemLowerHeight => _noteStem?.lowerHeight ?? 0.0;

//   double get _accidentalUpperHeight => _accidental?.upperHeight ?? 0.0;
//   double get _accidentalLowerHeight => _accidental?.lowerHeight ?? 0.0;

//   double get _noteUpperHeight => [
//         _noteHeadUpperHeight,
//         _noteFlagUpperHeight,
//         _noteStemUpperHeight,
//         _accidentalUpperHeight,
//       ].fold<double>(0.0,
//           (previousValue, notePartUpper) => max(previousValue, notePartUpper));

//   @override
//   double get upperHeight => _upperWithNoMargin + _margin.top;

//   double get _upperWithNoMargin => max(_noteUpperHeight, _fingeringHeight);

//   @override
//   double get lowerHeight => _lowerWithNoMargin + _margin.bottom;

//   double get _lowerWithNoMargin => [
//         _noteHeadLowerHeight,
//         _noteFlagLowerHeight,
//         _noteStemLowerHeight,
//         _accidentalLowerHeight
//       ].fold<double>(0.0,
//           (previousValue, notePartLower) => max(previousValue, notePartLower));

//   Rect get _bboxWithNoMargin =>
//       Rect.fromLTRB(0.0, -_upperWithNoMargin, _objectWidth, _lowerWithNoMargin);

//   double get _noteHeadWidth => noteHeadType.width;

//   double get _noteFlagWidth => _noteFlag?.width ?? 0.0;

//   double get _downNoteWidth => max(_noteHeadWidth, _noteFlagWidth);

//   double get _upNoteWithFlagWidth =>
//       _hasFlag ? _noteHeadWidth + _noteFlagWidth - NoteStem.stemThickness : 0.0;

//   double get _upNoteWidth => max(_upNoteWithFlagWidth, _noteHeadWidth);

//   double get _noteWidth => _isStemUp ? _upNoteWidth : _downNoteWidth;

//   @override
//   double get width => _objectWidth + _margin.horizontal;

//   double get _objectWidth => _accidentalWidth + _accidentalSpacing + _noteWidth;
// }

// class NoteRenderer implements MusicalSymbolRenderer {
//   static const _upperLedgerLineMinPosition = 6;
//   static const _lowerLedgerLineMaxPosition = -6;

//   final AccidentalRenderer? accidental;
//   final NoteStem? noteStem;
//   final int position;
//   final NoteHead noteHead;
//   final NoteFlag? noteFlag;
//   final FingeringRenderer? fingering;
//   // @override
//   // final ObjectOnCanvasHelper helper;

//   @override
//   final MusicalSymbol musicObjectStyle;
//   const NoteRenderer(this.musicObjectStyle,
//       {required this.noteHead,
//       required this.position,
//       this.accidental,
//       this.noteStem,
//       this.noteFlag,
//       this.fingering});

//   double get noteHeadInitialX => throw UnimplementedError();
//   // noteHead.initialX(helper.renderOffset);
//   double get noteHeadWidth => noteHead.width;
//   // Rect get renderArea => helper.renderArea;
//   bool get requireLedgerLine =>
//       position <= _lowerLedgerLineMaxPosition ||
//       _upperLedgerLineMinPosition <= position;

//   @override
//   void render(Canvas canvas, Size size, fontFamily) {
//     // accidental?.render(
//     //     canvas, size, helper.renderOffset, musicObjectStyle.color, fontFamily);
//     // noteHead.render(
//     //     canvas, size, helper.renderOffset, musicObjectStyle.color, fontFamily);
//     // noteStem?.render(canvas, musicObjectStyle.color, helper.renderOffset);
//     // noteFlag?.render(
//     //     canvas, size, helper.renderOffset, musicObjectStyle.color, fontFamily);
//     // fingering?.render(
//     //     canvas, size, helper.renderOffset, musicObjectStyle.color, fontFamily);
//   }

//   @override
//   bool isHit(Offset position) => throw UnimplementedError();

//   @override
//   Rect get renderArea => throw UnimplementedError();
//   // helper.renderArea;
// }
