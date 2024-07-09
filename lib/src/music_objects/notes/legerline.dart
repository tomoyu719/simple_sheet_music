import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/constants.dart';
import 'package:simple_sheet_music/src/music_objects/notes/positions.dart';

/// A class that renders leger lines for notes on a staff.
class LegerLineRenderer {
  /// Creates a [LegerLineRenderer] with the specified parameters.
  const LegerLineRenderer(
    this.lineColor,
    this.notePosition, {
    required this.staffLineCenterY,
    required this.noteCenterX,
    required this.legerLineWidth,
    required this.legerLineThickness,
  });

  /// The X-coordinate of the center of the note.
  final double noteCenterX;

  /// The width of the leger line.
  final double legerLineWidth;

  /// The thickness of the leger line.
  final double legerLineThickness;

  /// The position of the note on the staff.
  final StavePosition notePosition;

  /// The Y-coordinate of the center of the staff line.
  final double staffLineCenterY;

  /// The color of the leger line.
  final Color lineColor;

  /// The number of leger lines to be rendered.
  int get _legerLineNum => _isUpperLedgerLine
      ? notePosition.upperLedgerLineNum
      : notePosition.lowerLedgerLineNum;

  /// The positions of the leger lines relative to the staff line center.
  List<int> get _legerLinePositions {
    final positions = <int>[];
    if (_isUpperLedgerLine) {
      for (var i = 0; i < _legerLineNum; i++) {
        positions.add(i * 2 + _upperLedgerLineMinPosition);
      }
    } else {
      for (var i = 0; i < _legerLineNum; i++) {
        positions.add(-i * 2 + _lowerLedgerLineMinPosition);
      }
    }
    return positions;
  }

  /// The minimum position of the upper ledger line.
  static const _upperLedgerLineMinPosition = 6;

  /// The minimum position of the lower ledger line.
  static const _lowerLedgerLineMinPosition = -6;

  /// Checks if the note is an upper ledger line note.
  bool get _isUpperLedgerLine => notePosition.isUpperLedgerLine;

  /// Renders the leger lines on the canvas.
  void render(Canvas canvas) {
    for (final position in _legerLinePositions) {
      final y = staffLineCenterY + -1 * position * Constants.staffSpace / 2;
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
