import 'music_object_on_canvas.dart';

abstract class BuiltObject {
  /// height from measure's centerline to the top of the object
  final double upperHeight;

  /// height from measure's centerline to the bottom of the object
  final double lowerHeight;

  /// width of the object
  final double width;

  const BuiltObject(this.upperHeight, this.lowerHeight, this.width);

  ObjectOnCanvas placeOnCanvas(
      {required double staffLineCenterY,
      required double previousObjectsWidthSum});
}
