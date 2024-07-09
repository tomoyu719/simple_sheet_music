import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/src/staff/staff_metrics.dart';

class MockStaffMetrics extends Fake implements StaffMetrics {
  MockStaffMetrics({this.width = 0});

  @override
  final double width;
}
