import 'package:flutter/material.dart';
import 'package:simple_sheet_music/src/extension/rect_extension.dart';

/// A helper class for positioning and rendering objects on a canvas.
class ObjectOnCanvasHelper {
  final Rect bboxNoMargin;
  final Offset anchorOffset;
  final EdgeInsets margin;

  /// Constructs an [ObjectOnCanvasHelper] with the given parameters.
  const ObjectOnCanvasHelper(this.bboxNoMargin, this.anchorOffset, this.margin);

  /// The offset used for rendering the object on the canvas.
  Offset get renderOffset => anchorOffset.translate(margin.left, 0);

  /// The bounding box of the object with the applied margin.
  Rect get bboxWithMargin => bboxNoMargin.addMargin(margin);

  /// The area on the canvas where the object will be rendered.
  Rect get renderArea => bboxWithMargin.shift(renderOffset);

  /// Checks if the given position is within the render area of the object.
  bool isHit(Offset position) => renderArea.contains(position);
}
