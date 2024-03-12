import '../clef/clef_type.dart';
import 'music_object_on_canvas.dart';

abstract class BuiltObject {
  final ClefType clefType;
  // height from measure's centerline to the top of the object
  final double upperHeight;
  // height from measure's centerline to the bottom of the object
  final double lowerHeight;
  // width of the object
  final double width;

  BuiltObject(this.upperHeight, this.lowerHeight, this.width, this.clefType);

  ObjectOnCanvas placeOnCanvas(
      {required double staveCenterY, required double previousObjectsWidthSum});
}
