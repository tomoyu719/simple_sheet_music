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
  late final List<MusicalSymbol> musicObjects;
  late final Measure measure;

  @override
  void initState() {
    musicObjects = [
      const Clef(ClefType.treble),
      const Clef(ClefType.alto),
      const Clef(ClefType.tenor),
      const Clef(ClefType.bass),
    ];
    measure = Measure(musicObjects, isLineBreak: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sheetMusicSize = MediaQuery.of(context).size / 2;
    return Scaffold(
        appBar: AppBar(title: const Text('Simple Sheet Music Example')),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            height: sheetMusicSize.height,
            width: sheetMusicSize.width,
            child: Center(
              child: SimpleSheetMusic(
                fontType: FontType.petaluma,
                maximumHeight: sheetMusicSize.height / 2,
                maximumWidth: sheetMusicSize.width / 2,
                measures: [
                  measure,
                ],
              ),
            ),
          ),
        ));
  }
}
