import 'package:flutter/rendering.dart';

import '../clef/clef_type.dart';
import 'built_object.dart';

abstract class MusicObjectStyle {
  final EdgeInsets? specifiedMargin;
  final Color color;

  const MusicObjectStyle(this.color, this.specifiedMargin);
  MusicObjectStyle copyWith({Color? newColor, EdgeInsets? newSpecifiedMargin});

  BuiltObject build(ClefType clefType);
}
