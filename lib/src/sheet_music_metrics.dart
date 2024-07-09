import 'package:simple_sheet_music/src/extension/list_extension.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/measure/measure.dart';
import 'package:simple_sheet_music/src/measure/measure_metrics.dart';

import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/key_signature/keysignature_type.dart';
import 'package:simple_sheet_music/src/musical_context.dart';
import 'package:simple_sheet_music/src/staff/staff_metrics.dart';

/// Represents the metrics of a sheet music.
class SheetMusicMetrics {
  SheetMusicMetrics(
    this.measures,
    this.initialClefType,
    this.initialKeySignatureType,
    this.metadata,
    this.paths,
  );

  List<MeasureMetrics>? _measuresMetricsesCache;

  /// Gets the metrics of each measure in the sheet music.
  List<MeasureMetrics> get _measuresMetricses {
    if (_measuresMetricsesCache != null) {
      return _measuresMetricsesCache!;
    }
    final result = <MeasureMetrics>[];
    var context = MusicalContext(initialClefType, initialKeySignatureType);
    for (final measure in measures) {
      final symbols = measure.setContext(
        context,
        metadata,
        paths,
      );
      context = measure.updateContext(context);
      final measureMetrics =
          MeasureMetrics(symbols, metadata, isNewLine: measure.isNewLine);
      result.add(measureMetrics);
    }

    return _measuresMetricsesCache ??= result;
  }

  List<StaffMetrics>? _staffsMetricses;

  /// Gets the metrics of each staff in the sheet music.
  List<StaffMetrics> get staffsMetricses {
    if (_staffsMetricses != null) {
      return _staffsMetricses!;
    }
    final staffs = <StaffMetrics>[];
    var sameStaffMeasures = <MeasureMetrics>[];
    for (final measure in _measuresMetricses) {
      if (measure.isNewLine && sameStaffMeasures.isNotEmpty) {
        staffs.add(StaffMetrics(sameStaffMeasures));
        sameStaffMeasures = [measure];
      } else {
        sameStaffMeasures.add(measure);
      }
    }
    if (sameStaffMeasures.isNotEmpty) {
      staffs.add(StaffMetrics(sameStaffMeasures));
    }
    return _staffsMetricses ??= staffs;
  }

  final List<Measure> measures;
  final ClefType initialClefType;
  final KeySignatureType initialKeySignatureType;
  final GlyphMetadata metadata;
  final GlyphPaths paths;

  /// Gets the staff with the maximum width in the sheet music.
  StaffMetrics get _maximumWidthStaff {
    var result = staffsMetricses.first;
    for (final staff in staffsMetricses) {
      if (staff.width > result.width) {
        result = staff;
      }
    }
    return result;
  }

  /// Gets the maximum width of a staff in the sheet music.
  double get maximumStaffWidth => _maximumWidthStaff.width;

  double get maximumStaffHorizontalMarginSum =>
      _maximumWidthStaff.horizontalMarginSum;

  /// Gets the upper height of all the staffs in the sheet music.
  double get staffUpperHeight =>
      staffsMetricses.map((staff) => staff.upperHeight).max;

  /// Gets the lower height of all the staffs in the sheet music.
  double get staffLowerHeight =>
      staffsMetricses.map((staff) => staff.lowerHeight).max;

  /// Gets the sum of the heights of all the staffs in the sheet music.
  double get staffsHeightSum =>
      staffsMetricses.map((staff) => staff.height).sum;
}
