import 'dart:math';

import 'package:flutter/material.dart';

import 'staff/built_staff.dart';
import 'staff/staff_on_canvas.dart';

/// The `SheetMusicPlacer` is responsible for calculating the layout of the staffs on the canvas.
class SheetMusicLayout {
  final List<BuiltStaff> _staffsContainMeasures;
  final EdgeInsets margin;
  final double width;
  final double height;

  const SheetMusicLayout(
      this._staffsContainMeasures, this.margin, this.width, this.height);

  double get canvasScale {
    final staffsHeightSum = _staffsContainMeasures.fold<double>(
        0.0, (previousValue, element) => previousValue + element.height);
    final staffsMaxWidth = _staffsContainMeasures.fold<double>(
        0.0, (previousValue, element) => max(previousValue, element.width));
    final widthScale = (width - margin.horizontal) / staffsMaxWidth;
    final heightScale = (height - margin.vertical) / staffsHeightSum;
    return min(widthScale, heightScale);
  }

  List<StaffOnCanvas> get staffsOnCanvas {
    final sheetMusicMargin = margin / canvasScale;
    double currentHeightSum = sheetMusicMargin.top;
    final placedStaffs = <StaffOnCanvas>[];
    for (final staff in _staffsContainMeasures) {
      final staffLineCenterY = currentHeightSum + staff.upperHeight;
      placedStaffs.add(staff.placeOnCanvas(staffLineCenterY, sheetMusicMargin));
      currentHeightSum += staff.height;
    }
    return placedStaffs;
  }
}
