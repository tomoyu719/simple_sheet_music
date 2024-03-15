import 'dart:math';
import 'dart:ui';

import '../measure/built_measure.dart';
import '../measure/measure.dart';
import '../music_objects/clef/clef.dart';
import '../music_objects/key_signature/key_signature.dart';
import 'built_staff.dart';
import 'staff.dart';

class StaffBuilder {
  const StaffBuilder();

  /// Returns a list of MeasureContainsObjects for each measure in the staff.
  BuiltStaff buildStaff(
    Staff staff,
    Clef staffInitialClef,
    KeySignature keySignature,
    Color lineColor, {
    bool isBeginStaff = false,
    bool isEndStaff = false,
  }) {
    final measures = staff.measures;
    var currentClef = staffInitialClef;
    var currentKeySignature = keySignature;
    final builtMeasures = <BuiltMeasure>[];
    for (var index = 0; index < measures.length; index++) {
      final measure = measures[index];
      final previousMeasure = index == 0 ? null : measures[index - 1];
      final isBeginMeasure = isBeginStaff && index == 0;
      final isEndMeasure = isEndStaff && index == measures.length - 1;
      final isLeftMostMeasure = index == 0;
      currentClef = previousMeasure?.lastClef ?? currentClef;
      final builtMeasure = measure.buildMeasure(
          currentClef,
          currentKeySignature,
          isLeftMostMeasure: isLeftMostMeasure,
          isBeginMeasure: isBeginMeasure,
          isEndMeasure: isEndMeasure,
          lineColor);
      builtMeasures.add(builtMeasure);
    }
    return BuiltStaff(builtMeasures, lineColor,
        width: _objectsWidthSum(builtMeasures),
        upperHeight: _objectsUppestHeight(builtMeasures),
        lowerHeight: _objectsLowestHeight(builtMeasures));
  }

  double _objectsWidthSum(List<BuiltMeasure> builtMeasures) =>
      builtMeasures.fold(0.0, (sum, measure) => sum + measure.width);
  double _objectsUppestHeight(List<BuiltMeasure> builtMeasures) =>
      builtMeasures.fold(Measure.measureMinUpperHeight,
          (maxHeight, measure) => max(maxHeight, measure.upperHeight));
  double _objectsLowestHeight(List<BuiltMeasure> builtMeasures) =>
      builtMeasures.fold(Measure.measureMinLowerHeight,
          (maxHeight, measure) => max(maxHeight, measure.lowerHeight));
}
