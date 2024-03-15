import 'dart:core';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'font_types.dart';
import 'music_objects/clef/clef.dart';
import 'music_objects/interface/music_object_style.dart';
import 'music_objects/key_signature/key_signature.dart';
import 'sheet_music_builder.dart';
import 'sheet_music_gesture_handler.dart';
import 'sheet_music_layout.dart';
import 'staff/staff.dart';

typedef OnTapMusicObjectCallback = void Function(
    MusicObjectStyle musicObject, Offset offset);

/// The `SimpleSheetMusic` widget is used to display sheet music.
/// It takes a list of `Staff` objects, an initial clef, and other optional parameters to customize the appearance of the sheet music.
class SimpleSheetMusic extends StatefulWidget {
  const SimpleSheetMusic({
    Key? key,
    required this.staffs,
    required this.initialClef,
    this.initialKeySignature = const KeySignature(KeySignatureType.cMajor),
    this.margin = EdgeInsets.zero,
    this.height = 400.0,
    this.width = 400.0,
    this.onTap,
    this.lineColor = Colors.black,
  }) : super(key: key);

  /// The margin around the sheet music.
  final EdgeInsets margin;

  /// The list of staffs to be displayed.
  final List<Staff> staffs;

  /// The height of the sheet music.
  final double height;

  /// The width of the sheet music.
  final double width;

  /// The font type to be used for rendering the sheet music.
  FontType get fontType => FontType.bravura;

  /// The initial clef  for the sheet music.
  final Clef initialClef;

  /// The initial keySignature for the sheet music.
  final KeySignature initialKeySignature;

  /// A callback function that is called when a music object is tapped.
  final OnTapMusicObjectCallback? onTap;

  final Color lineColor;

  @override
  SimpleSheetMusicState createState() => SimpleSheetMusicState();
}

/// The state class for the SimpleSheetMusic widget.
///
/// This class manages the state of the SimpleSheetMusic widget and handles the initialization,
/// font asset loading, and building of the widget.
class SimpleSheetMusicState extends State<SimpleSheetMusic> {
  late final AsyncMemoizer memoizer;
  late SheetMusicLayout layout;
  late SheetMusicBuilder staffsBuilder;

  FontType get fontType => widget.fontType;

  @override
  void initState() {
    memoizer = AsyncMemoizer();
    staffsBuilder = SheetMusicBuilder(widget.staffs, widget.initialClef,
        widget.initialKeySignature, widget.lineColor);
    layout = SheetMusicLayout(
        staffsBuilder.buildStaffs, widget.margin, widget.width, widget.height);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SimpleSheetMusic oldWidget) {
    staffsBuilder = SheetMusicBuilder(widget.staffs, widget.initialClef,
        widget.initialKeySignature, widget.lineColor);
    layout = SheetMusicLayout(
        staffsBuilder.buildStaffs, widget.margin, widget.width, widget.height);
    super.didUpdateWidget(oldWidget);
  }

  /// Loads the font assets required for rendering the sheet music.
  Future<void> _loadFontAssets() async {
    final font = rootBundle.load(fontType.path);
    final fontLoader = FontLoader(fontType.name);
    fontLoader.addFont(font);
    await fontLoader.load();
  }

  @override
  Widget build(BuildContext context) {
    final targetSize = Size(widget.width, widget.height);

    return memoizer.hasRun
        ? SheetMusicGestureHandler(targetSize, layout.canvasScale, widget.onTap,
            layout.staffsOnCanvas, fontType.name)
        : FutureBuilder(
            future: memoizer.runOnce(() async => await _loadFontAssets()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SheetMusicGestureHandler(targetSize, layout.canvasScale,
                    widget.onTap, layout.staffsOnCanvas, fontType.name);
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
  }
}
