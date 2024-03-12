import 'package:flutter_test/flutter_test.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';
import 'package:simple_sheet_music/src/music_objects/interface/built_object.dart';

class MockMusicObjectStyle extends Fake implements MusicObjectStyle {
  final double lowerHeight;

  final double upperHeight;

  final double width;

  MockMusicObjectStyle(
      {this.lowerHeight = 0, this.upperHeight = 0, this.width = 0});

  @override
  BuiltObject build(ClefType clefType) => MockBuiltObject(clefType,
      lowerHeight: lowerHeight, upperHeight: upperHeight, width: width);
}

class MockBuiltObject extends Fake implements BuiltObject {
  final ClefType clefType;
  @override
  final double lowerHeight;
  @override
  final double upperHeight;
  @override
  final double width;

  MockBuiltObject(this.clefType,
      {this.lowerHeight = 0, this.upperHeight = 0, this.width = 0});
}
