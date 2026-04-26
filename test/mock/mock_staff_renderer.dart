import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/staff/staff_renderer.dart';

class MockStaffRenderer extends Fake implements StaffRenderer {
  MockStaffRenderer({this.width = 0});

  @override
  final double width;

  @override
  void setPosition({
    required double canvasScale,
    required double staffLineCenterY,
    required double leftPadding,
  }) {}
}
