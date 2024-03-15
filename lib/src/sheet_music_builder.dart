import 'dart:ui';

import 'music_objects/clef/clef.dart';
import 'music_objects/key_signature/key_signature.dart';
import 'staff/built_staff.dart';
import 'staff/staff.dart';

/// A builder class for creating sheet music.
class SheetMusicBuilder {
  final Clef initialClef;
  final KeySignature initialKeySignature;
  final List<Staff> staffs;
  final Color sheetMusicLineColor;

  /// Constructs a [SheetMusicBuilder] with the given [staffs] and [initialClef].
  const SheetMusicBuilder(this.staffs, this.initialClef,
      this.initialKeySignature, this.sheetMusicLineColor);

  /// Returns a list of [BuiltStaff] objects that contain measures for each staff.
  List<BuiltStaff> get buildStaffs {
    final staffsContainMeasure = <BuiltStaff>[];
    var currentStaffClef = initialClef;
    var currentKeySignature = initialKeySignature;
    for (var index = 0; index < staffs.length; index++) {
      final staff = staffs[index];
      final isBeginStaff = index == 0;
      final isEndStaff = index == staffs.length - 1;
      currentStaffClef =
          _previsouStaffLastcurrentClefType(index) ?? currentStaffClef;
      currentKeySignature = staff.keySignature ?? currentKeySignature;
      final builtStaff = staff.buildStaff(
        currentStaffClef,
        currentKeySignature,
        sheetMusicLineColor,
        isBeginStaff: isBeginStaff,
        isEndStaff: isEndStaff,
      );
      staffsContainMeasure.add(builtStaff);
    }
    return staffsContainMeasure;
  }

  /// Returns the last clef of the previous staff at the given [index].
  Clef? _previsouStaffLastcurrentClefType(int index) {
    if (index - 1 < 0) return null;
    final previousStaff = staffs[index - 1];
    return previousStaff.lastClef;
  }
}
