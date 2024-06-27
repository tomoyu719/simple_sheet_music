// import 'package:flutter/material.dart';
// import 'package:simple_sheet_music/src/music_objects/clef/clef_type.dart';
// import 'package:simple_sheet_music/src/music_objects/interface/musical_symbol_renderer.dart';
// import 'package:simple_sheet_music/src/music_objects/interface/music_object_on_canvas_helper.dart';
// import 'package:simple_sheet_music/src/sheet_music_layout.dart';

// import '../../mixins/text_paint_mixin.dart';
// import '../interface/built_object.dart';
// import '../interface/musical_symbol.dart';
// import 'rest_type.dart';

// class Rest implements MusicalSymbol, BuiltObject {
//   final RestType restType;
//   @override
//   final Color color;
//   @override
//   final EdgeInsets? specifiedMargin;

//   const Rest(this.restType, {this.color = Colors.black, this.specifiedMargin});

//   @override
//   BuiltObject build(ClefType clefType) => this;

//   @override
//   MusicalSymbol copyWith({Color? newColor, EdgeInsets? newSpecifiedMargin}) =>
//       Rest(restType,
//           color: newColor ?? color,
//           specifiedMargin: newSpecifiedMargin ?? specifiedMargin);
//   EdgeInsets get margin => specifiedMargin ?? _defaultMargin;
//   EdgeInsets get _defaultMargin =>
//       EdgeInsets.symmetric(horizontal: restType.bbox.width / 4);

//   @override
//   double get lowerHeight => restType.bbox.bottom + margin.bottom;

//   @override
//   MusicalSymbolRenderer placeOnCanvas(
//       {required double staffLineCenterY,
//       required double previousObjectsWidthSum}) {
//     final offsetX = previousObjectsWidthSum + restType.offsetX;
//     final offsetY = staffLineCenterY + restType.offsetY;
//     final renderOffset = Offset(offsetX, offsetY);
//     // final helper = ObjectOnCanvasHelper(restType.bbox, renderOffset, margin);
//     // return RestRenderer(helper, restType.glyph, this);
//     throw UnimplementedError();
//   }

//   @override
//   double get upperHeight => restType.bbox.top + margin.top;

//   @override
//   double get width => restType.bbox.width + margin.horizontal;

//   @override
//   MusicalSymbolRenderer renderer(SheetMusicLayout layout) {
//     // `TODO`: implement renderer
//     throw UnimplementedError();
//   }
// }

// class RestRenderer with TextPaint implements MusicalSymbolRenderer {
//   // @override
//   // final ObjectOnCanvasHelper helper;

//   @override
//   final MusicalSymbol musicalSymbol;

//   RestRenderer(this.musicalSymbol, this.layout);
//   @override
//   final SheetMusicLayout layout;

//   @override
//   bool isHit(Offset position) => throw UnimplementedError();
//   // helper.isHit(position);

//   @override
//   void render(Canvas canvas, Size size) {
//     // textPaint(canvas, size, glyph, helper.renderOffset, musicObjectStyle.color,
//     //     fontFamily);
//   }

//   @override
//   Rect get renderArea => throw UnimplementedError();

//   @override
//   // `TODO`: implement width
//   double get width => throw UnimplementedError();

//   @override
//   // `TODO`: implement lowerHeight
//   double get lowerHeight => throw UnimplementedError();

//   @override
//   // `TODO`: implement upperHeight
//   double get upperHeight => throw UnimplementedError();

//   @override
//   late final Offset renderOffset;
// }
