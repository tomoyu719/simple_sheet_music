import 'dart:math';
import 'dart:ui';

import '../measure/built_measure.dart';
import '../measure/measure.dart';
import '../music_objects/clef/clef_type.dart';
import 'built_staff.dart';
import 'staff.dart';

class StaffBuilder {
  const StaffBuilder();

  /// Returns a list of MeasureContainsObjects for each measure in the staff.
  BuiltStaff buildStaff(Staff staff, ClefType staffInitialClefType,
      bool isEndStaff, Color lineColor) {
    final measures = staff.measures;
    ClefType currentClefType = staffInitialClefType;
    final builtMeasures = <BuiltMeasure>[];
    for (var index = 0; index < measures.length; index++) {
      final measure = measures[index];
      final previousMeasure = index == 0 ? null : measures[index - 1];
      final isEndMeasure = isEndStaff && index == measures.length - 1;
      currentClefType = previousMeasure?.lastClef?.clefType ?? currentClefType;
      final builtMeasure = measure.buildMeasure(
          currentClefType, isEndMeasure: isEndMeasure, lineColor);
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
