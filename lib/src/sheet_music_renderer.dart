import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

/// A custom painter that renders the sheet music based on the provided layout.
class SheetMusicRenderer extends CustomPainter {
  const SheetMusicRenderer(this.sheetMusicLayout);

  final SheetMusicLayout sheetMusicLayout;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(sheetMusicLayout.canvasScale);
    sheetMusicLayout.render(canvas, size);
  }

  @override
  bool shouldRepaint(SheetMusicRenderer oldDelegate) => true;
}
