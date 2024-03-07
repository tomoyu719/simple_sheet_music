import 'dart:ui';

import '../music_objects/interface/built_object.dart';
import '../music_objects/music_object_on_canvas.dart';
import 'barline/barline.dart';
import 'ledgerline/ledgerline.dart';
import 'measure_on_canvas.dart';
import 'staffline.dart';

/// Represents a measure that contains musical objects.
class BuiltMeasure {
  final List<BuiltObject> builtObjects;
  final Color lineColor;
  final Barline barline;

  final double upperHeight;
  final double lowerHeight;
  final double objectsWidth;

  /// Constructs a MeasureContainsObjects object.
  ///
  /// The [builtObjects] parameter is a list of [BuiltObject] that represent the musical objects in the measure.
  /// The [lineColor] parameter specifies the color of the staff lines.
  /// The [barline] parameter specifies the type of barline to be displayed at the end of the measure.
  const BuiltMeasure(this.builtObjects, this.lineColor, this.barline,
      {required this.upperHeight,
      required this.lowerHeight,
      required this.objectsWidth});

  double get width => objectsWidth + _barlineWidth;

  double get _barlineWidth => barline.width;

  List<ObjectOnCanvas> _placeObjectsOnCanvas(
      double staffLineCenterY, double measureInitialX) {
    var currentObjectX = measureInitialX;
    final objectsOnCanvas = <ObjectOnCanvas>[];
    for (final object in builtObjects) {
      final placedObject = object.placeOnCanvas(
          staveCenterY: staffLineCenterY,
          previousObjectsWidthSum: currentObjectX);
      objectsOnCanvas.add(placedObject);
      currentObjectX += object.width;
    }
    return objectsOnCanvas;
  }

  MeasureOnCanvas placeOnCanvas(
      double staffLineCenterY, double measureInitialX) {
    final measureEndX = measureInitialX + width;
    final bbox = Rect.fromLTRB(measureInitialX, staffLineCenterY - upperHeight,
        measureEndX, staffLineCenterY + lowerHeight);
    final barlineRenderer = barline.renderer(lineColor,
        measureEndX: measureEndX, staffLineCenterY: staffLineCenterY);

    return MeasureOnCanvas(
      _placeObjectsOnCanvas(staffLineCenterY, measureInitialX),
      staffLineCenterY,
      width,
      lineColor,
      measureInitialX,
      barlineRenderer,
      bbox,
      LedgerLineRenderer(lineColor, staffLineCenterY),
      StaffLineRenderer(lineColor,
          width: width,
          staffLineCenterY: staffLineCenterY,
          staffLineInitialX: measureInitialX),
    );
  }
}
