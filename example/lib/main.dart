import 'package:flutter/material.dart';
import 'package:simple_sheet_music/simple_sheet_music.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SimpleSheetMusicDemo());
  }
}

class SimpleSheetMusicDemo extends StatefulWidget {
  const SimpleSheetMusicDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return SimpleSheetMusicDemoState();
  }
}

class SimpleSheetMusicDemoState extends State {
  late final List<MusicObjectStyle> musicObjects;
  late final Measure measure;
  late final Staff staff;
  late final ClefType initialClefType;

  @override
  void initState() {
    initialClefType = ClefType.treble;
    musicObjects = [
      const Clef(ClefType.treble),
      const Note(
          pitch: Pitch.c4,
          noteDuration: NoteDuration.eighth,
          accidental: Accidental.sharp,
          fingering: Fingering.one),
      const Note(
          pitch: Pitch.e4,
          noteDuration: NoteDuration.eighth,
          fingering: Fingering.two),
      const Note(
          pitch: Pitch.g4,
          noteDuration: NoteDuration.eighth,
          fingering: Fingering.three),
      const Note(
          pitch: Pitch.c5,
          noteDuration: NoteDuration.eighth,
          accidental: Accidental.flat,
          fingering: Fingering.four),
    ];
    measure = Measure(musicObjects);
    staff = Staff([measure]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height / 2;
    final width = screenSize.width;
    return Scaffold(
        appBar: AppBar(title: const Text('Simple Sheet Music Example')),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SimpleSheetMusic(
            initialClef: initialClefType,
            margin: const EdgeInsets.all(10),
            height: height,
            width: width,
            staffs: [staff],
          )
        ]));
  }
}
