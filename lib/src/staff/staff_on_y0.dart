import 'package:simple_sheet_music/simple_sheet_music.dart';
import 'package:simple_sheet_music/src/extension/list_extension.dart';
import 'package:simple_sheet_music/src/measure/measure_on_y0.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';
import 'package:simple_sheet_music/src/staff/staff_renderer.dart';

class StaffOnY0 {
  StaffOnY0(List<Measure> measures, this.layout)
      : measuresOnY0 =
            measures.map((measure) => measure.setOnY0(layout)).toList();
  late final List<MeasureOnY0> measuresOnY0;
  final SheetMusicLayout layout;

  double get upperHeight =>
      measuresOnY0.map((measure) => measure.upperHeight).max;
  double get lowerHeight =>
      measuresOnY0.map((measure) => measure.lowerHeight).max;

  double get width => measuresOnY0.map((measure) => measure.width).sum;

  double get height => measuresOnY0
      .map((measure) => measure.upperHeight + measure.lowerHeight)
      .max;
  StaffRenderer renderer(
          {required double staffLineCenterY, required double leftPadding,}) =>
      StaffRenderer(measuresOnY0,
          staffLineCenterY: staffLineCenterY, leftPadding: leftPadding,);
}
