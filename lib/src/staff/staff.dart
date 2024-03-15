import 'dart:core';

import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/staff/built_staff.dart';
import 'package:simple_sheet_music/src/staff/staff_builder.dart';

import '../../simple_sheet_music.dart';

/// Represents a musical staff that contains a list of measures.
class Staff {
  final List<Measure> measures;
  final Color? staffLineColor;
  final StaffBuilder _staffBuilder;

  /// Constructs a Staff object with the given list of measures and an optional line color.
  const Staff(this.measures, {this.staffLineColor})
      : _staffBuilder = const StaffBuilder(),
        assert(measures.length != 0);

  /// Returns the last keySignature object in the staff, or null if there are no keySignatures.
  KeySignature? get keySignature {
    final staffObjects =
        measures.map((measure) => measure.objectStyles).expand((e) => e);
    final keySignatures = staffObjects.whereType<KeySignature>();
    return keySignatures.isEmpty ? null : keySignatures.last;
  }

  /// Returns the last clef object in the staff, or null if there are no clefs.
  Clef? get lastClef {
    final staffObjects =
        measures.map((measure) => measure.objectStyles).expand((e) => e);
    final clefs = staffObjects.whereType<Clef>();
    return clefs.isEmpty ? null : clefs.last;
  }

  BuiltStaff buildStaff(
    Clef staffInitialClef,
    KeySignature keySignature,
    Color sheetMusicLineColor, {
    required bool isBeginStaff,
    required bool isEndStaff,
  }) =>
      _staffBuilder.buildStaff(
        this,
        staffInitialClef,
        keySignature,
        staffLineColor ?? sheetMusicLineColor,
        isBeginStaff: isBeginStaff,
        isEndStaff: isEndStaff,
      );
}
