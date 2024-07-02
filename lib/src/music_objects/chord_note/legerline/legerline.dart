import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/constants.dart';

import 'legerline_helper.dart';

class LegerLineRenderer {
  const LegerLineRenderer(
    this.lineColor,
    this.notePosition, {
    required this.staffLineCenterY,
    required this.noteCenterX,
    required this.legerLineWidth,
    required this.legerLineThickness,
  });
  final double noteCenterX;
  final double legerLineWidth;
  final double legerLineThickness;
  final int notePosition;
  final double staffLineCenterY;
  final Color lineColor;

  int get legerLineNum => _isUpperLedgerLine
      ? upperLedgerLineNum(notePosition)
      : lowerLedgerLineNum(notePosition);

  List<int> get legerLinePositions {
    final List<int> positions = [];
    if (_isUpperLedgerLine) {
      for (var i = 0; i < legerLineNum; i++) {
        positions.add(i * 2 + upperLedgerLineMinPosition);
      }
    } else {
      for (var i = 0; i < legerLineNum; i++) {
        positions.add(-i * 2 + lowerLedgerLineMinPosition);
      }
    }
    return positions;
  }

  static const upperLedgerLineMinPosition = 6;
  static const lowerLedgerLineMinPosition = -6;

  bool get _isUpperLedgerLine => notePosition > 0;

  void render(Canvas canvas) {
    for (final position in legerLinePositions) {
      final y = staffLineCenterY + -1 * position * staffSpace / 2;
      canvas.drawLine(
        Offset(noteCenterX - legerLineWidth / 2, y),
        Offset(noteCenterX + legerLineWidth / 2, y),
        Paint()
          ..color = lineColor
          ..strokeWidth = legerLineThickness,
      );
    }
  }
}
