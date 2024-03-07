import 'dart:math';
import 'dart:ui';

import '../music_objects/clef/clef.dart';
import '../music_objects/clef/clef_type.dart';

import '../music_objects/interface/built_object.dart';
import '../music_objects/interface/music_object_style.dart';
import 'barline/barline.dart';
import 'measure.dart';
import 'built_measure.dart';

/// This file contains the implementation of the MeasureBuilder class.
/// MeasureBuilder is responsible for building a BuiltMeasure object based on a Measure object and other parameters.
/// It calculates the width and height of the objects in the measure and determines the type of barline to be used.
/// The built measure is used for rendering the measure in the sheet music.
class MeasureBuilder {
  const MeasureBuilder();

  /// Returns the default barline based on whether the measure is the end measure or not.
  Barline _defaultBarline(bool isEndMeasure) =>
      isEndMeasure ? Barline.barlineFinal : Barline.barlineThin;

  /// Builds a BuiltMeasure object based on the given Measure object, initial clef type, measure line color, and whether it is the end measure or not.
  BuiltMeasure buildMeasure(Measure measure, ClefType measureInitialClefType,
      {required Color measureLineColor, required bool isEndMeasure}) {
    final builtObjects =
        _buildObjects(measureInitialClefType, measure.objectStyles);

    return BuiltMeasure(
      builtObjects,
      measureLineColor,
      measure.barline ?? _defaultBarline(isEndMeasure),
      upperHeight: _objectsUppestHeight(builtObjects),
      lowerHeight: _objectsLowestHeight(builtObjects),
      objectsWidth: _objectsWidthSum(builtObjects),
    );
  }

  /// Builds a list of BuiltObject based on the initial clef type and the list of MusicObjectStyle.
  List<BuiltObject> _buildObjects(
      ClefType initialClefType, List<MusicObjectStyle> objects) {
    List<BuiltObject> builtObjects = [];
    var currentClefType = initialClefType;
    for (final object in objects) {
      currentClefType = object is Clef ? object.clefType : currentClefType;
      builtObjects.add(object.build(currentClefType));
    }
    return builtObjects;
  }

  /// Calculates the sum of the widths of the objects in the measure.
  double _objectsWidthSum(List<BuiltObject> objects) =>
      objects.fold(0.0, (sum, object) => sum + object.width);

  /// Calculates the maximum upper height among the objects in the measure.
  double _objectsUppestHeight(List<BuiltObject> objects) => objects.fold(
      Measure.measureMinUpperHeight,
      (maxHeight, object) => max(maxHeight, object.upperHeight));

  /// Calculates the maximum lower height among the objects in the measure.
  double _objectsLowestHeight(List<BuiltObject> objects) => objects.fold(
      Measure.measureMinLowerHeight,
      (maxHeight, object) => max(maxHeight, object.lowerHeight));
}
