import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

class SheetMusicRenderer extends CustomPainter {
  const SheetMusicRenderer(this.sheetMusicLayout);
  final SheetMusicLayout sheetMusicLayout;

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
    //     Paint()..color = Colors.red);
    canvas.scale(sheetMusicLayout.scale);
    sheetMusicLayout.render(canvas, size);
  }

  @override
  bool shouldRepaint(SheetMusicRenderer oldDelegate) => true;
}
