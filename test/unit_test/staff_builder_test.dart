import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';
import 'package:simple_sheet_music/src/measure/barline/barline.dart';
import 'package:simple_sheet_music/src/staff/staff_builder.dart';

import '../mock/mock_music_object.dart';

void main() {
  test('StaffBuilder should build staff correctly', () {
    // Arrange
    const staffBuilder = StaffBuilder();
    const staffInitialClefType = ClefType.treble;
    const isEndStaff = true;
    final measures = [
      Measure([MockMusicObjectStyle()]),
      Measure([MockMusicObjectStyle()]),
      Measure([MockMusicObjectStyle()]),
    ];
    final staff = Staff(measures);
    const lineColor = Colors.black;

    // Act
    final builtStaff = staffBuilder.buildStaff(
      staff,
      staffInitialClefType,
      isEndStaff,
      lineColor,
    );

    // Assert
    expect(builtStaff.measures.length, 3);
  });
  test('isEndStaff true', () {
    // Arrange
    const staffBuilder = StaffBuilder();
    const staffInitialClefType = ClefType.treble;
    const isEndStaff = true;
    final measures = [
      Measure([MockMusicObjectStyle()]),
      Measure([MockMusicObjectStyle()]),
      Measure([MockMusicObjectStyle()]),
    ];
    const lineColor = Colors.black;
    final staff = Staff(measures);

    // Act
    final builtStaff = staffBuilder.buildStaff(
      staff,
      staffInitialClefType,
      isEndStaff,
      lineColor,
    );

    // Assert
    expect(builtStaff.measures[0].barline, Barline.barlineThin);
    expect(builtStaff.measures[1].barline, Barline.barlineThin);
    expect(builtStaff.measures[2].barline, Barline.barlineFinal);
  });
  test('isEndStaff false', () {
    // Arrange
    const staffBuilder = StaffBuilder();
    const staffInitialClefType = ClefType.treble;
    const isEndStaff = false;
    final measures = [
      Measure([MockMusicObjectStyle()]),
      Measure([MockMusicObjectStyle(), const Clef(ClefType.alto)]),
      Measure([MockMusicObjectStyle()]),
    ];
    const lineColor = Colors.black;
    final staff = Staff(measures);

    // Act
    final builtStaff = staffBuilder.buildStaff(
      staff,
      staffInitialClefType,
      isEndStaff,
      lineColor,
    );

    // Assert
    expect(builtStaff.measures[0].builtObjects.first.clefType, ClefType.treble);
    expect(builtStaff.measures[1].builtObjects.first.clefType, ClefType.treble);
    expect(builtStaff.measures[2].builtObjects.first.clefType, ClefType.alto);
  });
}
