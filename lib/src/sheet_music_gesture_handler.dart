import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'music_objects/interface/music_object_style.dart';
import 'sheet_music_renderer.dart';
import 'simple_sheet_music.dart';
import 'staff/staff_on_canvas.dart';

/// The `SheetMusicGestureHandler` is a widget that handles user interactions with the sheet music.
class SheetMusicGestureHandler extends StatelessWidget {
  final Size widgetSize;
  final double canvasScale;
  final OnTapMusicObjectCallback? onTap;

  final List<StaffOnCanvas> staffsOnCanvas;
  final String fontFamily;
  const SheetMusicGestureHandler(this.widgetSize, this.canvasScale, this.onTap,
      this.staffsOnCanvas, this.fontFamily,
      {Key? key})
      : super(key: key);

  void _onTap(TapUpDetails d) {
    final tapped = _hitTest(d.localPosition);
    if (tapped != null) {
      onTap?.call(tapped, d.globalPosition);
    }
  }

  MusicObjectStyle? _hitTest(Offset screenOffset) {
    final canvasPosition = screenOffset.scale(1 / canvasScale, 1 / canvasScale);
    for (final staff in staffsOnCanvas) {
      final object = staff.hitTest(canvasPosition);
      if (object != null) {
        final tappedObject = object.musicObjectStyle;
        return tappedObject;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // return Slider(value: value, onChanged: onChanged)
    return GestureDetector(
        onTapUp: _onTap,
        child: SizedBox(
          height: widgetSize.height,
          width: widgetSize.width,
          child: CustomPaint(
            size: widgetSize,
            painter:
                SheetMusicRenderer(staffsOnCanvas, canvasScale, fontFamily),
          ),
        ));
  }
}
