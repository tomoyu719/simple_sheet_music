import 'dart:ui';

import 'music_objects/clef/clef_type.dart';
import 'staff/built_staff.dart';
import 'staff/staff.dart';

/// A builder class for creating sheet music.
class SheetMusicBuilder {
  final ClefType initialClefType;
  final List<Staff> staffs;
  final Color sheetMusicLineColor;

  /// Constructs a [SheetMusicBuilder] with the given [staffs] and [initialClefType].
  const SheetMusicBuilder(
      this.staffs, this.initialClefType, this.sheetMusicLineColor);

  /// Returns a list of [BuiltStaff] objects that contain measures for each staff.
  List<BuiltStaff> get buildStaffs {
    final staffsContainMeasure = <BuiltStaff>[];
    var currentStaffClefType = initialClefType;
    for (var index = 0; index < staffs.length; index++) {
      final staff = staffs[index];
      final isEndStaff = index == staffs.length - 1;
      currentStaffClefType =
          _previsouStaffLastClef(index) ?? currentStaffClefType;
      final builtStaff = staff.buildStaff(
          currentStaffClefType, isEndStaff, sheetMusicLineColor);
      staffsContainMeasure.add(builtStaff);
    }
    return staffsContainMeasure;
  }

  /// Returns the last clef of the previous staff at the given [index].
  ClefType? _previsouStaffLastClef(int index) {
    if (index - 1 < 0) return null;
    final previousStaff = staffs[index - 1];
    return previousStaff.lastClef?.clefType;
  }
}
