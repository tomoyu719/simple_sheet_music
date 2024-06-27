import 'dart:core';

import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/measure/measure_on_y0.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

import '../../simple_sheet_music.dart';

import 'barline/barline.dart';

import 'staffline.dart';

/// Represents a musical measure.
class Measure {
  // final KeySignature? keySignature;

  /// Constructs a Measure object.
  ///
  /// The [musicalSymbols] parameter is a list of [MusicalSymbol] that represent the musical objects in the measure.
  /// The [measureLineColor] parameter specifies the color of the staff lines.
  const Measure(
    this.musicalSymbols, {
    this.measureLineColor,
    // this.barline,
    this.isLineBreak = false,
  }) : assert(musicalSymbols.length != 0);
  static const double measureMinUpperHeight =
      StaffLineRenderer.staffLineSpaceHeight * 2 +
          StaffLineRenderer.staffLineThickness / 2;
  static const double measureMinLowerHeight =
      StaffLineRenderer.staffLineSpaceHeight * 2 +
          StaffLineRenderer.staffLineThickness / 2;

  // final MeasureBuilder _measureBuilder;

  final List<MusicalSymbol> musicalSymbols;

  final Color? measureLineColor;
  // final Barline? barline;
  final bool isLineBreak;

  // BuiltMeasure buildMeasure(
  //   Clef measureInitialClef,
  //   KeySignature keySignature,
  //   Color staffLineColor, {
  //   bool isLeftMostMeasure = false,
  //   bool isBeginMeasure = false,
  //   bool isEndMeasure = false,
  // }) {
  //   return _measureBuilder.buildMeasure(
  //     this,
  //     measureInitialClef,
  //     this.keySignature ?? keySignature,
  //     measureLineColor ?? staffLineColor,
  //     isLeftMostMeasure: isLeftMostMeasure,
  //     isBeginMeasure: isBeginMeasure,
  //     isEndMeasure: isEndMeasure,
  //   );
  // }

  Clef? get lastClef {
    for (final object in musicalSymbols.reversed) {
      if (object is Clef) {
        return object;
      }
    }
    return null;
  }

  MeasureOnY0 setOnY0(SheetMusicLayout layout) {
    return MeasureOnY0(musicalSymbols, layout);
  }

  // MeasureRenderer renderer(SheetMusicLayout layout) {
  //   return MeasureRenderer(musicalSymbols, layout);
  // }
}
