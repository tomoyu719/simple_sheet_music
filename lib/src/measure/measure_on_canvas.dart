import 'dart:ui';

import '../mixins/debug_paint_mixin.dart';
import '../mixins/draw_line_mixin.dart';
import '../music_objects/interface/music_object_on_canvas.dart';
import '../music_objects/note/note.dart';
import 'barline/barline_renderer.dart';
import 'ledgerline/ledgerline.dart';
import 'staffline.dart';

/// Represents a measure rendered on a canvas.
/// This class is responsible for rendering the staff lines, ledger lines, music objects, and barlines of a measure.
class MeasureOnCanvas with LineDrawer, DebugPaint {
  final List<ObjectOnCanvas> musicObjects;
  final double staffLineCenterY;
  final double width;
  final Color lineColor;
  final double staffLineInitialX;
  final BarlineRenderer barlineRenderer;
  final Rect bbox;
  final LedgerLineRenderer ledgerLineRenderer;
  final StaffLineRenderer staffLineRenderer;

  /// Constructs a MeasureOnCanvas object.
  ///
  /// The [musicObjects] parameter is a list of music objects to be rendered in the measure.
  /// The [staffLineCenterY] parameter is the y-coordinate of the center of the staff lines.
  /// The [width] parameter is the width of the measure.
  /// The [lineColor] parameter is the color of the staff lines and ledger lines.
  /// The [staffLineInitialX] parameter is the initial x-coordinate of the staff lines.
  /// The [barlineRenderer] parameter is the renderer for the barline.
  /// The [bbox] parameter is the bounding box of the measure.
  const MeasureOnCanvas(
      this.musicObjects,
      this.staffLineCenterY,
      this.width,
      this.lineColor,
      this.staffLineInitialX,
      this.barlineRenderer,
      this.bbox,
      this.ledgerLineRenderer,
      this.staffLineRenderer);

  /// Performs a hit test on the measure to determine if any music object is hit at the given [position].
  ///
  /// Returns the music object that is hit, or null if no object is hit.
  ObjectOnCanvas? hitTest(Offset position) {
    for (final object in musicObjects) {
      if (object.isHit(position)) {
        return object;
      }
    }
    return null;
  }

  /// Renders the staff lines on the canvas.
  void _renderStaffLine(Canvas canvas) => staffLineRenderer.render(canvas);

  /// Gets a list of note painters from the music objects.
  List<NoteRenderer> get _notes =>
      musicObjects.whereType<NoteRenderer>().toList();

  /// Gets a list of note painters that require ledger lines.
  List<NoteRenderer> get _requiredLedgerLineNotes =>
      _notes.where((element) => element.requireLedgerLine).toList();

  /// Renders the ledger lines on the canvas.
  void _renderRedgerLine(Canvas canvas) {
    for (final note in _requiredLedgerLineNotes) {
      final noteHeadInitialX = note.noteHeadInitialX;
      final noteHeadWidth = note.noteHeadWidth;
      final notePosition = note.position;
      ledgerLineRenderer.render(canvas, notePosition,
          noteHeadWidth: noteHeadWidth, noteHeadInitialX: noteHeadInitialX);
    }
  }

  /// Renders all the music objects on the canvas.
  void _renderObjects(Canvas canvas, Size size, String fontFamily) {
    for (final object in musicObjects) {
      object.render(canvas, size, fontFamily);
      boxPaint(canvas, size, object.renderArea);
    }
  }

  /// Renders the barline on the canvas.
  void _renderBarLine(Canvas canvas) => barlineRenderer.render(canvas);

  /// Renders the measure on the canvas.
  ///
  /// The [size] parameter is the size of the canvas.
  /// The [fontFamily] parameter is the font family used for rendering text.
  void render(Canvas canvas, Size size, String fontFamily) {
    _renderStaffLine(canvas);
    _renderRedgerLine(canvas);
    _renderObjects(canvas, size, fontFamily);
    _renderBarLine(canvas);
    // boxPaint(canvas, size, bbox, color: Colors.green);
  }
}
