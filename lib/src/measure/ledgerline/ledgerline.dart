import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/measure/staffline.dart';
import '../../mixins/draw_line_mixin.dart';
import 'ledgerline_helper.dart';

/// The `LedgerLine` class represents a ledger line in a musical staff. It is responsible for rendering the ledger line on a canvas.
class LedgerLineRenderer with LineDrawer {
  static const _ledgerLineThickness = 0.16;
  static const _ledgerLineWidthMultiplier = 1.5;
  static const _staffLineCenterToAboveLedgerLineHeight =
      StaffLineRenderer.staffLineSpaceHeight * 3;
  static const _staffLineCenterToBelowLedgerLineHeight =
      StaffLineRenderer.staffLineSpaceHeight * 3;

  final double staffLineCenterY;
  final Color lineColor;

  const LedgerLineRenderer(
    this.lineColor,
    this.staffLineCenterY,
  );

  double get _upperLedgerInitialY =>
      staffLineCenterY - _staffLineCenterToAboveLedgerLineHeight;
  double get _lowerLedgerInitialY =>
      staffLineCenterY + _staffLineCenterToBelowLedgerLineHeight;

  double _noteHeadHalfWidth(double noteHeadWidth) => noteHeadWidth / 2;

  double _ledgerLineHalfWidth(double noteHeadWidth) =>
      _ledgerLineWidth(noteHeadWidth) / 2;
  double _ledgerLineWidth(double noteHeadWidth) =>
      noteHeadWidth * _ledgerLineWidthMultiplier;

  double _ledgerLineInitialX(
          {required double noteHeadWidth, required double noteHeadInitialX}) =>
      noteHeadInitialX +
      _noteHeadHalfWidth(noteHeadWidth) -
      _ledgerLineHalfWidth(noteHeadWidth);

  Iterable<double> _upperLedgerLineYs(int notePosition) =>
      List.generate(_upperLedgerLineNum(notePosition), (ledgerLinePosition) {
        final ledgerLineHeight =
            -ledgerLinePosition * StaffLineRenderer.staffLineSpaceHeight;
        return ledgerLineHeight + _upperLedgerInitialY;
      });

  Iterable<double> _lowerLedgerLineYs(int notePosition) =>
      List.generate(_lowerLedgerLineNum(notePosition), (ledgerLinePosition) {
        final ledgerLineHeight =
            ledgerLinePosition * StaffLineRenderer.staffLineSpaceHeight;
        return ledgerLineHeight + _lowerLedgerInitialY;
      });

  Iterable<double> ledgerLineYs(notePosition) =>
      _isUpperLedgerLine(notePosition)
          ? _upperLedgerLineYs(notePosition)
          : _lowerLedgerLineYs(notePosition);

  bool _isUpperLedgerLine(int notePosition) => notePosition > 0;

  int _upperLedgerLineNum(int notePosition) => upperLedgerLineNum(notePosition);
  int _lowerLedgerLineNum(int notePosition) => lowerLedgerLineNum(notePosition);

  Iterable<Offset> _ledgerLineInitialOffsets(int notePosition,
          {required double noteHeadWidth, required double noteHeadInitialX}) =>
      ledgerLineYs(notePosition).map((y) => Offset(
          _ledgerLineInitialX(
              noteHeadWidth: noteHeadWidth, noteHeadInitialX: noteHeadInitialX),
          y));

  void render(Canvas canvas, int notePosition,
      {required double noteHeadWidth, required double noteHeadInitialX}) {
    for (final initialOffset in _ledgerLineInitialOffsets(notePosition,
        noteHeadWidth: noteHeadWidth, noteHeadInitialX: noteHeadInitialX)) {
      final endOffset =
          initialOffset.translate(_ledgerLineWidth(noteHeadWidth), 0);
      drawLine(
          canvas, initialOffset, endOffset, _ledgerLineThickness, lineColor);
    }
  }
}
