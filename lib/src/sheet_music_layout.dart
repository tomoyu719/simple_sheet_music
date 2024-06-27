import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';
import 'package:simple_sheet_music/src/extension/list_extension.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/staff/staff_on_y0.dart';

import 'staff/staff_renderer.dart';

class SheetMusicLayout {

  SheetMusicLayout(
    this.measures,
    this.metadata,
    this.glyphPaths,
    this.lineColor, {
    required this.maximumHeight,
    required this.maximumWidth,
  }) {
    staffs = _createStaffs(measures);

    staffsOnY0 = staffs.map((staff) => staff.setOnY0(this)).toList();
    scale =
        _canvasScale(maximumWidth: maximumWidth, maximumHeight: maximumHeight);
    staffRenderers = setRenderer(staffsOnY0,
        upperPadding: upperPadding, leftPadding: leftPadding,);
  }
  final List<Measure> measures;
  late final List<Staff> staffs;
  late final List<StaffOnY0> staffsOnY0;
  late final List<StaffRenderer> staffRenderers;
  final double maximumWidth;
  final double maximumHeight;
  late final double scale;
  final GlyphPaths glyphPaths;
  final GlyphMetadata metadata;
  final Color lineColor;

  double get horizontalPadding => maximumWidth / scale - _staffsMaximumWidth;
  double get verticalPadding => maximumHeight / scale - _staffsHeightsSum;
  double get upperPadding => verticalPadding / 2;
  double get leftPadding => horizontalPadding / 2;

  double get staffLineThickness => metadata.staffLineThickness;

  // // // `TODO` rename
  // void setRenderer() {
  //   var currentY = upperPadding;
  //   for (final staff in staffRenderers) {
  //     currentY += staff.upperHeight;
  //     staff.setOffset(currentY, leftPadding);
  //     currentY += staff.lowerHeight;
  //   }
  // }

  // TODOrename

  double _canvasScale(
      {required double maximumWidth, required double maximumHeight,}) {
    final widthScale = maximumWidth / _staffsMaximumWidth;
    final heightScale = maximumHeight / _staffsHeightsSum;
    return min(widthScale, heightScale);
  }

  double get _staffsMaximumWidth => staffsOnY0.map((staff) => staff.width).max;

  double get _staffsHeightsSum => staffsOnY0.map((staff) => staff.height).sum;

  void render(Canvas canvas, Size size) {
    for (final staff in staffRenderers) {
      staff.render(canvas, size);
    }
  }

  // TODOrename
  Path getPath(String pathKey) => glyphPaths.getPath(pathKey);
}

// TODOrename
List<Staff> _createStaffs(List<Measure> inputMeasures) {
  final staffs = <Staff>[];
  var measures = <Measure>[];
  for (final measure in inputMeasures) {
    measures.add(measure);
    if (measure.isLineBreak) {
      final staff = Staff(measures);
      staffs.add(staff);
      measures = <Measure>[];
    }
  }
  if (measures.isNotEmpty) {
    final staff = Staff(measures);
    staffs.add(staff);
  }
  return staffs;
}

// TODOrename
List<StaffRenderer> setRenderer(List<StaffOnY0> staffs,
    {required double upperPadding, required double leftPadding,}) {
  var currentY = upperPadding;
  final renderers = <StaffRenderer>[];
  for (final staff in staffs) {
    currentY += staff.upperHeight;
    final renderer =
        staff.renderer(staffLineCenterY: currentY, leftPadding: leftPadding);
    renderers.add(renderer);
    currentY += staff.lowerHeight;
  }
  return renderers;
}
