import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';
import 'package:simple_sheet_music/src/measure/barline/barline.dart';
import 'package:simple_sheet_music/src/measure/measure_builder.dart';

import '../mock/mock_music_object.dart';

void main() {
  test('MeasureBuilder should build a measure correctly', () {
    // Arrange

    const initialClef = Clef(ClefType.treble);
    final objectStyles = [MockMusicObjectStyle()];
    final measure = Measure(objectStyles);
    const measureBuilder = MeasureBuilder();
    const keySignature = KeySignature(KeySignatureType.cMajor);

    // Act
    final builtMeasure = measureBuilder.buildMeasure(
      measure,
      initialClef,
      keySignature,
      Colors.black,
    );

    // Assert
    expect(builtMeasure.builtObjects.length, objectStyles.length);
  });

  test(
      'MeasureBuilder should properly build measures even if different clef types are in the middle.',
      () {
    // Arrange
    const initialClef = Clef(ClefType.treble);
    const middleClef = Clef(ClefType.bass);
    const keySignature = KeySignature(KeySignatureType.cMajor);
    final measure = Measure([
      MockMusicObjectStyle(),
      middleClef,
      MockMusicObjectStyle(),
    ]);
    const measureBuilder = MeasureBuilder();

    // Act
    final builtMeasure = measureBuilder.buildMeasure(
      measure,
      initialClef,
      keySignature,
      Colors.black,
    );

    // Assert
    expect((builtMeasure.builtObjects[0] as MockBuiltObject).clefType,
        ClefType.treble);
    expect((builtMeasure.builtObjects[2] as MockBuiltObject).clefType,
        middleClef.clefType);
  });

  test('MeasureBuilder should build a measure with correctly barline', () {
    // Arrange
    const initialClef = Clef(ClefType.treble);
    const keySignature = KeySignature(KeySignatureType.cMajor);
    final measure = Measure([MockMusicObjectStyle()]);
    const measureBuilder = MeasureBuilder();
    const isEndMeasure = false;
    const isBeginMeasure = true;

    // Act
    final builtMeasure = measureBuilder.buildMeasure(
      measure,
      initialClef,
      keySignature,
      Colors.black,
      isBeginMeasure: isBeginMeasure,
      isEndMeasure: isEndMeasure,
    );

    // Assert
    expect(builtMeasure.barline, Barline.barlineThin);
  });

  test(
      'MeasureBuilder should build a measure with the correct bar line when it is the end measure',
      () {
    // Arrange
    const initialClef = Clef(ClefType.treble);
    const keySignature = KeySignature(KeySignatureType.cMajor);
    final measure = Measure([MockMusicObjectStyle()]);
    const measureBuilder = MeasureBuilder();
    const isEndMeasure = true;

    // Act
    final builtMeasure = measureBuilder.buildMeasure(
      measure,
      initialClef,
      keySignature,
      Colors.black,
      isEndMeasure: isEndMeasure,
    );

    // Assert
    expect(builtMeasure.barline, Barline.barlineFinal);
  });

  test(
      'MeasureBuilder should build a measure with the correct bar line when it is not the end measure',
      () {
    // Arrange
    const initialClef = Clef(ClefType.treble);
    const keySignature = KeySignature(KeySignatureType.cMajor);
    final measure = Measure([MockMusicObjectStyle()]);
    const measureBuilder = MeasureBuilder();
    const isEndMeasure = false;

    // Act
    final builtMeasure = measureBuilder.buildMeasure(
      measure,
      initialClef,
      keySignature,
      Colors.black,
      isEndMeasure: isEndMeasure,
    );

    // Assert
    expect(builtMeasure.barline, Barline.barlineThin);
  });

  test(
      'MeasureBuilder should build a measure with the correct width and heights',
      () {
    // Arrange
    const initialClef = Clef(ClefType.treble);
    const keySignature = KeySignature(KeySignatureType.cMajor);

    final measure = Measure([
      MockMusicObjectStyle(upperHeight: 10, lowerHeight: 5, width: 5),
      MockMusicObjectStyle(upperHeight: 5, lowerHeight: 10, width: 5),
      MockMusicObjectStyle(upperHeight: 5, lowerHeight: 5, width: 5),
    ]);

    const measureBuilder = MeasureBuilder();
    const isEndMeasure = false;

    // Act
    final builtMeasure = measureBuilder.buildMeasure(
      measure,
      initialClef,
      keySignature,
      Colors.black,
      isEndMeasure: isEndMeasure,
    );

    // Assert
    expect(builtMeasure.upperHeight, 10);
    expect(builtMeasure.lowerHeight, 10);
    expect(builtMeasure.objectsWidth, 15);
  });
}
