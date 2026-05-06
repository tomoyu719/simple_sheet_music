import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/constants.dart';
import 'package:simple_sheet_music/src/glyph_metadata.dart';
import 'package:simple_sheet_music/src/glyph_path.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol.dart';
import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';
import 'package:simple_sheet_music/src/music_objects/time_signature/time_signature_type.dart';
import 'package:simple_sheet_music/src/musical_context.dart';
import 'package:simple_sheet_music/src/sheet_music_layout.dart';

/// Represents a time signature in sheet music.
///
/// Time signatures can be displayed either as numeric values (e.g., 4/4, 3/4)
/// or as symbols (common time "C" or cut time "₵").
///
/// Use with `Measure.timeSignature` parameter:
/// ```dart
/// Measure(
///   [Clef.treble()],
///   timeSignature: TimeSignature.fourFour(),
/// )
/// ```
class TimeSignature implements MusicalSymbol {
  /// Creates a time signature with the specified numerator and denominator.
  ///
  /// Both [numerator] and [denominator] must be between 1 and 99 inclusive.
  TimeSignature(
    int numerator,
    int denominator, {
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  }) : timeSignatureType = NumericTimeSignature(numerator, denominator);

  const TimeSignature._({
    required this.timeSignatureType,
    this.color = Colors.black,
    this.margin = const EdgeInsets.all(10),
  });

  /// Creates a time signature from a [TimeSignatureType].
  ///
  /// This is useful when you have a [TimeSignatureType] instance and want to
  /// create a [TimeSignature] from it.
  const TimeSignature.fromType(
    TimeSignatureType type, {
    Color color = Colors.black,
    EdgeInsets margin = const EdgeInsets.all(10),
  }) : this._(
          timeSignatureType: type,
          color: color,
          margin: margin,
        );

  /// Creates a common time signature (4/4) displayed as the "C" symbol.
  const TimeSignature.commonTime({
    Color color = Colors.black,
    EdgeInsets margin = const EdgeInsets.all(10),
  }) : this._(
          timeSignatureType: const CommonTimeSignature(),
          color: color,
          margin: margin,
        );

  /// Creates a cut time signature (2/2) displayed as the "₵" symbol.
  const TimeSignature.cutTime({
    Color color = Colors.black,
    EdgeInsets margin = const EdgeInsets.all(10),
  }) : this._(
          timeSignatureType: const CutTimeSignature(),
          color: color,
          margin: margin,
        );

  /// Creates a 4/4 time signature displayed as numbers.
  const TimeSignature.fourFour({
    Color color = Colors.black,
    EdgeInsets margin = const EdgeInsets.all(10),
  }) : this._(
          timeSignatureType: const NumericTimeSignature(4, 4),
          color: color,
          margin: margin,
        );

  /// Creates a 3/4 time signature displayed as numbers.
  const TimeSignature.threeFour({
    Color color = Colors.black,
    EdgeInsets margin = const EdgeInsets.all(10),
  }) : this._(
          timeSignatureType: const NumericTimeSignature(3, 4),
          color: color,
          margin: margin,
        );

  /// Creates a 2/4 time signature displayed as numbers.
  const TimeSignature.twoFour({
    Color color = Colors.black,
    EdgeInsets margin = const EdgeInsets.all(10),
  }) : this._(
          timeSignatureType: const NumericTimeSignature(2, 4),
          color: color,
          margin: margin,
        );

  /// Creates a 6/8 time signature displayed as numbers.
  const TimeSignature.sixEight({
    Color color = Colors.black,
    EdgeInsets margin = const EdgeInsets.all(10),
  }) : this._(
          timeSignatureType: const NumericTimeSignature(6, 8),
          color: color,
          margin: margin,
        );

  /// Creates a 9/8 time signature displayed as numbers.
  const TimeSignature.nineEight({
    Color color = Colors.black,
    EdgeInsets margin = const EdgeInsets.all(10),
  }) : this._(
          timeSignatureType: const NumericTimeSignature(9, 8),
          color: color,
          margin: margin,
        );

  /// Creates a 12/8 time signature displayed as numbers.
  const TimeSignature.twelveEight({
    Color color = Colors.black,
    EdgeInsets margin = const EdgeInsets.all(10),
  }) : this._(
          timeSignatureType: const NumericTimeSignature(12, 8),
          color: color,
          margin: margin,
        );

  /// The type of time signature.
  final TimeSignatureType timeSignatureType;

  @override
  final Color color;

  @override
  final EdgeInsets margin;

  @override
  MusicalSymbolRenderer setContext(
    MusicalContext context,
    GlyphMetadata metadata,
    GlyphPaths paths,
  ) =>
      TimeSignatureRenderer(this, paths);
}

/// Helper class to hold path and width together.
class _PathWithWidth {
  const _PathWithWidth(this.path, this.width);
  final Path path;
  final double width;
}

/// Renders the time signature symbol and provides its metrics.
class TimeSignatureRenderer implements MusicalSymbolRenderer {
  TimeSignatureRenderer(this.timeSignature, this.paths);

  final TimeSignature timeSignature;
  final GlyphPaths paths;

  /// Tracking space between digits (in staff space units).
  static const double _digitTracking = 0.04;

  TimeSignatureType get _type => timeSignature.timeSignatureType;

  /// Returns the SMuFL path key for a digit (0-9).
  String _digitPathKey(int digit) => 'uniE08$digit';

  /// Composes a path for a multi-digit number by horizontally arranging digit glyphs.
  Path _composeNumberPath(int number) {
    final digits = number.toString().split('').map(int.parse).toList();
    final composedPath = Path();
    var currentX = 0.0;

    for (var i = 0; i < digits.length; i++) {
      final digitPath = paths.parsePath(_digitPathKey(digits[i]));
      final digitBounds = digitPath.getBounds();

      // Shift the digit path to the current x position, accounting for the glyph's left edge
      final shiftedPath =
          digitPath.shift(Offset(currentX - digitBounds.left, 0));
      composedPath.addPath(shiftedPath, Offset.zero);

      // Move x position by the digit width plus tracking
      currentX += digitBounds.width + _digitTracking * Constants.staffSpace;
    }

    return composedPath;
  }

  /// Builds the complete path for a numeric time signature.
  _PathWithWidth _buildNumericPath() {
    final numeratorPath = _composeNumberPath(_type.numerator);
    final denominatorPath = _composeNumberPath(_type.denominator);

    final numeratorBounds = numeratorPath.getBounds();
    final denominatorBounds = denominatorPath.getBounds();

    final totalWidth = math.max(numeratorBounds.width, denominatorBounds.width);

    // Center the numerator horizontally
    final numeratorXOffset = (totalWidth - numeratorBounds.width) / 2;
    // Center the denominator horizontally
    final denominatorXOffset = (totalWidth - denominatorBounds.width) / 2;

    // Position numerator above staff center (Y = -1 staff space)
    // Position denominator below staff center (Y = +1 staff space)
    const numeratorY = -1 * Constants.staffSpace;
    const denominatorY = 1 * Constants.staffSpace;

    final resultPath = Path()
      // Add numerator path centered at top
      ..addPath(
        numeratorPath,
        Offset(numeratorXOffset - numeratorBounds.left,
            numeratorY - numeratorBounds.center.dy),
      )
      // Add denominator path centered at bottom
      ..addPath(
        denominatorPath,
        Offset(denominatorXOffset - denominatorBounds.left,
            denominatorY - denominatorBounds.center.dy),
      );

    return _PathWithWidth(resultPath, totalWidth);
  }

  /// Builds the complete path for a symbol time signature (common time or cut time).
  _PathWithWidth _buildSymbolPath() {
    late final String pathKey;
    if (_type is CommonTimeSignature) {
      pathKey = (_type as CommonTimeSignature).pathKey;
    } else if (_type is CutTimeSignature) {
      pathKey = (_type as CutTimeSignature).pathKey;
    } else {
      throw StateError(
          'Symbol path requested for non-symbol time signature type');
    }

    final symbolPath = paths.parsePath(pathKey);
    final bounds = symbolPath.getBounds();

    // Shift path to start at x=0 and center vertically on the staff
    final shiftedPath =
        symbolPath.shift(Offset(-bounds.left, -bounds.center.dy));

    return _PathWithWidth(shiftedPath, bounds.width);
  }

  /// The built path and width, cached for efficiency.
  late final _PathWithWidth _builtPath =
      _type is NumericTimeSignature ? _buildNumericPath() : _buildSymbolPath();

  Path get path => _builtPath.path;

  Rect get bbox => path.getBounds();

  @override
  double get width => _builtPath.width;

  @override
  double get upperHeight => -bbox.top;

  @override
  double get lowerHeight => bbox.bottom;

  @override
  EdgeInsets get margin => timeSignature.margin;

  double get _marginLeft => timeSignature.margin.left;

  Color get _color => timeSignature.color;

  @override
  void render(
    Canvas canvas, {
    required SheetMusicLayout layout,
    required double staffLineCenterY,
    required double symbolX,
  }) {
    final paint = Paint()..color = _color;
    canvas.drawPath(_renderPath(layout, staffLineCenterY, symbolX), paint);
  }

  @override
  bool isHit(
    Offset position, {
    required SheetMusicLayout layout,
    required double staffLineCenterY,
    required double symbolX,
  }) =>
      _renderArea(layout, staffLineCenterY, symbolX).contains(position);

  Offset _renderOffset(
    SheetMusicLayout layout,
    double staffLineCenterY,
    double symbolX,
  ) =>
      Offset(symbolX, staffLineCenterY) + _marginOffset(layout);

  Offset _marginOffset(SheetMusicLayout layout) =>
      Offset(_marginLeft, 0) / layout.canvasScale;

  Rect _renderArea(
    SheetMusicLayout layout,
    double staffLineCenterY,
    double symbolX,
  ) =>
      bbox.shift(_renderOffset(layout, staffLineCenterY, symbolX));

  Path _renderPath(
    SheetMusicLayout layout,
    double staffLineCenterY,
    double symbolX,
  ) =>
      path.shift(_renderOffset(layout, staffLineCenterY, symbolX));
}
