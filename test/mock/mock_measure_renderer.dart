import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/measure/measure_renderer.dart';

class MockMeasureRenderer extends Fake implements MeasureRenderer {
  MockMeasureRenderer({
    this.upperHeight = 0.0,
    this.lowerHeight = 0.0,
    this.objectsWidth = 0.0,
    this.horizontalMarginSum = 0.0,
  });

  @override
  final double upperHeight;
  @override
  final double lowerHeight;
  @override
  final double objectsWidth;
  @override
  final double horizontalMarginSum;

  @override
  void setPosition({
    required double canvasScale,
    required double measureInitialX,
    required double staffLineCenterY,
  }) {}

  @override
  double width(double scale) => objectsWidth + horizontalMarginSum / scale;
}
