import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/constants.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_y0.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

import '../interface/musical_symbol.dart';
import '../interface/musical_symbol_renderer.dart';
import 'clef_type.dart';

class Clef implements MusicalSymbol {

  const Clef(this.clefType, {this.specifiedMargin, this.color = Colors.black});
  final ClefType clefType;
  @override
  final Color color;
  @override
  final EdgeInsets? specifiedMargin;

  @override
  String toString() => 'Clef(ClefType: $clefType)';

  @override
  MusicalSymbolOnY0 renderer(SheetMusicLayout layout) => ClefOnY0(this, layout);
}

class ClefOnY0 implements MusicalSymbolOnY0 {
  const ClefOnY0(this.clef, this.layout);

  @override
  double get lowerHeight => bboxOnY0.bottom;

  @override
  // TODO: implement musicalSymbol
  MusicalSymbol get musicalSymbol => clef;
  final Clef clef;

  // @override
  // MusicalSymbolRenderer renderer() {
  //   return ClefRenderer(this, renderOffset);
  // }

  @override
  double get upperHeight => -bboxOnY0.top;

  @override
  double get width => bboxOnY0.width;

  Path get path => layout.getPath(clefType.pathKey);
  Rect get bbox => path.getBounds();
  Offset get defaultOffset =>
      Offset(-bbox.left, clefType.offsetUnitHeight * staffSpace);
  Path get pathOnY0 => path.shift(defaultOffset);
  Rect get bboxOnY0 => pathOnY0.getBounds();

  ClefType get clefType => clef.clefType;

  final SheetMusicLayout layout;
  Color get color => clef.color;

  @override
  MusicalSymbolRenderer renderer(
      {required double staffLineCenterY, required double symbolX,}) {
    return ClefRenderer(this,
        symbolX: symbolX, staffLineCenterY: staffLineCenterY,);
  }

  // @override
  // MusicalSymbolRenderer renderer(double staffLineCenterY, double symbolX) {
  //   return ClefRenderer(this,
  //       symbolX: symbolX, staffLineCenterY: staffLineCenterY);
  // }
}

class ClefRenderer implements MusicalSymbolRenderer {

  const ClefRenderer(this.clef,
      {required this.symbolX, required this.staffLineCenterY,});
  final ClefOnY0 clef;
  final double symbolX;
  final double staffLineCenterY;
  @override
  @override
  void render(Canvas canvas, Size size) {
    final p = Paint()..color = clef.color;
    canvas.drawPath(renderPath, p);
  }

  @override
  bool isHit(Offset position) => renderArea.contains(position);
  Offset get renderOffset => Offset(symbolX, staffLineCenterY);

  @override
  Rect get renderArea => clef.bboxOnY0.shift(renderOffset);

  Path get renderPath => clef.pathOnY0.shift(renderOffset);

  @override
  MusicalSymbolOnY0 get musicalSymbol => throw UnimplementedError();
}
