import 'package:simple_sheet_music/src/extension/list_extension.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/measure/measure.dart';
import 'package:simple_sheet_music/src/measure/measure_renderer.dart';

import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
import 'package:simple_sheet_music/src/music_objects/key_signature/keysignature_type.dart';
import 'package:simple_sheet_music/src/musical_context.dart';
import 'package:simple_sheet_music/src/staff/staff_renderer.dart';

/// Represents the metrics of a sheet music.
class SheetMusicMetrics {
  SheetMusicMetrics(
    this.measures,
    this.initialClefType,
    this.initialKeySignatureType,
    this.metadata,
    this.paths,
  );

  List<MeasureRenderer>? _measureRenderersCache;

  /// Gets the renderers of each measure in the sheet music.
  List<MeasureRenderer> get _measureRenderers {
    if (_measureRenderersCache != null) {
      return _measureRenderersCache!;
    }
    final result = <MeasureRenderer>[];
    var context = MusicalContext(initialClefType, initialKeySignatureType);
    for (final measure in measures) {
      final symbols = measure.setContext(
        context,
        metadata,
        paths,
      );
      context = measure.updateContext(context);
      final measureRenderer =
          MeasureRenderer(symbols, metadata, isNewLine: measure.isNewLine);
      result.add(measureRenderer);
    }

    return _measureRenderersCache ??= result;
  }

  List<StaffRenderer>? _staffRenderersCache;

  /// Gets the renderers of each staff in the sheet music.
  List<StaffRenderer> get staffRenderers {
    if (_staffRenderersCache != null) {
      return _staffRenderersCache!;
    }
    final staffs = <StaffRenderer>[];
    var sameStaffMeasures = <MeasureRenderer>[];
    for (final measure in _measureRenderers) {
      if (measure.isNewLine && sameStaffMeasures.isNotEmpty) {
        staffs.add(StaffRenderer(sameStaffMeasures));
        sameStaffMeasures = [measure];
      } else {
        sameStaffMeasures.add(measure);
      }
    }
    if (sameStaffMeasures.isNotEmpty) {
      staffs.add(StaffRenderer(sameStaffMeasures));
    }
    return _staffRenderersCache ??= staffs;
  }

  final List<Measure> measures;
  final ClefType initialClefType;
  final KeySignatureType initialKeySignatureType;
  final GlyphMetadata metadata;
  final GlyphPaths paths;

  /// Gets the staff with the maximum width in the sheet music.
  StaffRenderer get _maximumWidthStaff {
    var result = staffRenderers.first;
    for (final staff in staffRenderers) {
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
      staffRenderers.map((staff) => staff.upperHeight).max;

  /// Gets the lower height of all the staffs in the sheet music.
  double get staffLowerHeight =>
      staffRenderers.map((staff) => staff.lowerHeight).max;

  /// Gets the sum of the heights of all the staffs in the sheet music.
  double get staffsHeightSum => staffRenderers.map((staff) => staff.height).sum;
}
