import 'package:flutter/rendering.dart';

import 'music_object_on_canvas_helper.dart';
import 'music_object_style.dart';

abstract class ObjectOnCanvas {
  final MusicObjectStyle musicObjectStyle;
  final ObjectOnCanvasHelper helper;
  const ObjectOnCanvas(this.helper, this.musicObjectStyle);

  Rect get renderArea;

  bool isHit(Offset position);

  void render(Canvas canvas, Size size, String fontFamily);
}
