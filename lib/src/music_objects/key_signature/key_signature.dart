import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';
import 'package:simple_sheet_music/src/measure/staffline.dart';
import 'package:simple_sheet_music/src/mixins/text_paint_mixin.dart';
import 'package:simple_sheet_music/src/music_objects/interface/built_object.dart';
import 'package:simple_sheet_music/src/music_objects/interface/music_object_on_canvas.dart';

import '../../mixins/position_mixin.dart';
import '../interface/music_object_on_canvas_helper.dart';
import 'key_signature_helper.dart';

enum KeySignatureType {
  cMajor(keyNum: 0, isSharp: false, isFlat: false),
  aMinor(keyNum: 0, isSharp: false, isFlat: false),
  gMajor(keyNum: 1, isSharp: true, isFlat: false),
  eMinor(keyNum: 1, isSharp: true, isFlat: false),
  dMajor(keyNum: 2, isSharp: true, isFlat: false),
  bMinor(keyNum: 2, isSharp: true, isFlat: false),
  aMajor(keyNum: 3, isSharp: true, isFlat: false),
  fSharpMinor(keyNum: 3, isSharp: true, isFlat: false),
  eMajor(keyNum: 4, isSharp: true, isFlat: false),
  cSharpMinor(keyNum: 4, isSharp: true, isFlat: false),
  bMajor(keyNum: 5, isSharp: true, isFlat: false),
  gSharpMinor(keyNum: 5, isSharp: true, isFlat: false),
  fSharpMajor(keyNum: 6, isSharp: true, isFlat: false),
  dSharpMinor(keyNum: 6, isSharp: true, isFlat: false),
  cSharpMajor(keyNum: 7, isSharp: true, isFlat: false),
  aSharpMinor(keyNum: 7, isSharp: true, isFlat: false),
  fMajor(keyNum: 1, isSharp: false, isFlat: true),
  dMinor(keyNum: 1, isSharp: false, isFlat: true),
  bFlatMajor(keyNum: 2, isSharp: false, isFlat: true),
  gMinor(keyNum: 2, isSharp: false, isFlat: true),
  eFlatMajor(keyNum: 3, isSharp: false, isFlat: true),
  cMinor(keyNum: 3, isSharp: false, isFlat: true),
  aFlatMajor(keyNum: 4, isSharp: false, isFlat: true),
  fMinor(keyNum: 4, isSharp: false, isFlat: true),
  dFlatMajor(keyNum: 5, isSharp: false, isFlat: true),
  bFlatMinor(keyNum: 5, isSharp: false, isFlat: true),
  gFlatMajor(keyNum: 6, isSharp: false, isFlat: true),
  eFlatMinor(keyNum: 6, isSharp: false, isFlat: true),
  cFlatMajor(keyNum: 7, isSharp: false, isFlat: true),
  aFlatMinor(keyNum: 7, isSharp: false, isFlat: true);

  const KeySignatureType(
      {required this.keyNum, required this.isSharp, required this.isFlat})
      : assert(!(isSharp == true && isFlat == true));

  final int keyNum;
  final bool isSharp;
  final bool isFlat;

  List<int> keySignaturePositions(ClefType clefType) => isSharp
      ? clefType.sharpKeySignaturePositions.sublist(0, keyNum)
      : clefType.flatKeySignaturePositions.sublist(0, keyNum);
}

class KeySignature implements MusicObjectStyle {
  final KeySignatureType keySignatureType;

  @override
  final Color color;

  @override
  final EdgeInsets? specifiedMargin;

  const KeySignature(this.keySignatureType,
      {this.color = Colors.black, this.specifiedMargin});

  @override
  BuiltObject build(ClefType clefType) {
    final keySignaturePartPositions =
        keySignatureType.keySignaturePositions(clefType);

    return BuiltKeySignature(
        keySignatureParts(keySignaturePartPositions,
            isSharp: keySignatureType.isSharp),
        this,
        specifiedMargin);
  }

  @override
  MusicObjectStyle copyWith(
          {Color? newColor, EdgeInsets? newSpecifiedMargin}) =>
      KeySignature(
        keySignatureType,
        color: newColor ?? color,
        specifiedMargin: newSpecifiedMargin ?? specifiedMargin,
      );
}

class BuiltKeySignature implements BuiltObject {
  final List<KeySignaturePart> keySignatureParts;
  final KeySignature keySignature;

  final EdgeInsets? specifiedMargin;
  const BuiltKeySignature(
      this.keySignatureParts, this.keySignature, this.specifiedMargin);

  EdgeInsets get margin =>
      specifiedMargin ?? EdgeInsets.symmetric(horizontal: _objectWidth / 8);

  @override
  double get lowerHeight => keySignatureParts.fold(
      0.0, (maxV, element) => max(maxV, element.lowerHeight));

  @override
  double get upperHeight => keySignatureParts.fold(
      0.0, (maxV, element) => max(maxV, element.upperHeight));

  @override
  double get width => _objectWidth + margin.horizontal;

  double get _objectWidth =>
      keySignatureParts.fold(0.0, (sum, element) => sum + element.width);

  @override
  ObjectOnCanvas placeOnCanvas(
      {required double staffLineCenterY,
      required double previousObjectsWidthSum}) {
    final bbox = Rect.fromLTRB(0.0, -upperHeight, _objectWidth, lowerHeight);
    final helper = ObjectOnCanvasHelper(
        bbox, Offset(previousObjectsWidthSum, staffLineCenterY), margin);
    return KeySignatureOnCanvas(
      helper,
      keySignature,
      keySignatureParts,
    );
  }
}

class KeySignatureOnCanvas implements ObjectOnCanvas {
  @override
  final ObjectOnCanvasHelper helper;

  @override
  final MusicObjectStyle musicObjectStyle;

  final List<KeySignaturePart> keySignatureParts;

  const KeySignatureOnCanvas(
      this.helper, this.musicObjectStyle, this.keySignatureParts);

  @override
  bool isHit(Offset position) => helper.isHit(position);

  @override
  Rect get renderArea => helper.renderArea;

  @override
  void render(Canvas canvas, Size size, String fontFamily) {
    double currentX = 0.0;
    for (final part in keySignatureParts) {
      final renderOffset = helper.renderOffset + Offset(currentX, 0);
      part.render(
          canvas, size, renderOffset, musicObjectStyle.color, fontFamily);
      currentX += part.width;
    }
  }
}

class KeySignaturePart with HasPosition, TextPaint {
  static const _sharpGlyph = '♯';
  static const _flatGlyph = '♭';
  static const _sharpBbox = Rect.fromLTRB(0.0, -1.4, 0.996, 1.392);
  static const _flatBbox = Rect.fromLTRB(0.0, -1.756, 0.904, 0.7);

  final String _glyph;
  final int _position;
  final Rect _bbox;

  const KeySignaturePart.sharp(this._position)
      : _glyph = _sharpGlyph,
        _bbox = _sharpBbox;

  const KeySignaturePart.flat(this._position)
      : _glyph = _flatGlyph,
        _bbox = _flatBbox;

  double get width => _bbox.width;
  double get upperHeight => -_bbox.top + positionOffsetHeight(_position);
  double get lowerHeight => _bbox.bottom + positionOffsetHeight(_position);

  void render(
      Canvas canvas, Size size, Offset offset, Color color, String fontType) {
    offset += getPositionOffset(_position);
    textPaint(canvas, size, _glyph, offset, color, fontType);
  }
}
