import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/interface/music_object_on_canvas.dart';
import 'package:simple_sheet_music/src/music_objects/interface/music_object_on_canvas_helper.dart';

import '../../mixins/text_paint_mixin.dart';
import '../interface/built_object.dart';
import '../interface/music_object_style.dart';
import 'rest_type.dart';

class Rest implements MusicObjectStyle, BuiltObject {
  final RestType restType;
  @override
  final Color color;
  @override
  final EdgeInsets? specifiedMargin;

  const Rest(this.restType, {this.color = Colors.black, this.specifiedMargin});

  @override
  BuiltObject build(ClefType clefType) => this;

  @override
  MusicObjectStyle copyWith(
          {Color? newColor, EdgeInsets? newSpecifiedMargin}) =>
      Rest(restType,
          color: newColor ?? color,
          specifiedMargin: newSpecifiedMargin ?? specifiedMargin);
  EdgeInsets get margin => specifiedMargin ?? _defaultMargin;
  EdgeInsets get _defaultMargin =>
      EdgeInsets.symmetric(horizontal: restType.bbox.width / 4);

  @override
  double get lowerHeight => restType.bbox.bottom + margin.bottom;

  @override
  ObjectOnCanvas placeOnCanvas(
      {required double staffLineCenterY,
      required double previousObjectsWidthSum}) {
    final offsetX = previousObjectsWidthSum + restType.offsetX;
    final offsetY = staffLineCenterY + restType.offsetY;
    final renderOffset = Offset(offsetX, offsetY);
    final helper = ObjectOnCanvasHelper(restType.bbox, renderOffset, margin);
    return RestRenderer(helper, restType.glyph, this);
  }

  @override
  double get upperHeight => restType.bbox.top + margin.top;

  @override
  double get width => restType.bbox.width + margin.horizontal;
}

class RestRenderer with TextPaint implements ObjectOnCanvas {
  @override
  final ObjectOnCanvasHelper helper;
  @override
  final MusicObjectStyle musicObjectStyle;
  final String glyph;
  const RestRenderer(this.helper, this.glyph, this.musicObjectStyle);

  @override
  bool isHit(Offset position) => helper.isHit(position);

  @override
  void render(Canvas canvas, Size size, String fontFamily) {
    textPaint(canvas, size, glyph, helper.renderOffset, musicObjectStyle.color,
        fontFamily);
  }

  @override
  Rect get renderArea => helper.renderArea;
}
