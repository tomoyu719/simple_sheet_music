import 'package:flutter/material.dart';

import '../../mixins/text_paint_mixin.dart';
import '../interface/built_object.dart';
import '../interface/music_object_on_canvas.dart';
import '../interface/music_object_on_canvas_helper.dart';
import '../interface/music_object_style.dart';
import 'clef_type.dart';

class Clef implements MusicObjectStyle, BuiltObject {
  @override
  final ClefType clefType;
  @override
  final Color color;
  @override
  final EdgeInsets? specifiedMargin;
  EdgeInsets get margin => specifiedMargin ?? _defaultMargin(clefType);

  const Clef(this.clefType, {this.specifiedMargin, this.color = Colors.black});

  EdgeInsets _defaultMargin(ClefType clefType) =>
      EdgeInsets.symmetric(horizontal: clefType.width / 4);

  @override
  double get lowerHeight =>
      bboxWithNoMargin.bottom + clefType.offsetHeight + margin.bottom;

  @override
  double get upperHeight =>
      bboxWithNoMargin.top + clefType.offsetHeight + margin.top;

  @override
  double get width => clefType.width + margin.horizontal;

  @override
  BuiltObject build(ClefType clefType) => this;

  Rect get bboxWithNoMargin => clefType.glyphBbox;

  @override
  ObjectOnCanvas placeOnCanvas(
      {required double staveCenterY, required double previousObjectsWidthSum}) {
    final objectX = previousObjectsWidthSum + clefType.offsetX;
    final objectY = staveCenterY + clefType.offsetHeight;
    final renderOffset = Offset(objectX, objectY);
    final helper = ObjectOnCanvasHelper(bboxWithNoMargin, renderOffset, margin);
    return ClefPainter(clefType.glyph, helper, this);
  }

  @override
  String toString() => 'Clef(ClefType: $clefType)';

  @override
  MusicObjectStyle copyWith(
      {ClefType? newClefType,
      Color? newColor,
      EdgeInsets? newSpecifiedMargin}) {
    return Clef(newClefType ?? clefType,
        specifiedMargin: newSpecifiedMargin ?? specifiedMargin,
        color: newColor ?? color);
  }
}

class ClefPainter with TextPaint implements ObjectOnCanvas {
  final String glyph;
  @override
  final ObjectOnCanvasHelper helper;
  @override
  final MusicObjectStyle musicObjectStyle;

  const ClefPainter(this.glyph, this.helper, this.musicObjectStyle);

  @override
  void render(Canvas canvas, Size size, String fontFamily) {
    textPaint(canvas, size, glyph, helper.renderOffset, musicObjectStyle.color,
        fontFamily);
  }

  @override
  bool isHit(Offset position) => helper.isHit(position);

  @override
  Rect get renderArea => helper.renderArea;
}
