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
  late ClefType initialClefType;
  late List<MusicObjectStyle> objects;

  @override
  void initState() {
    initialClefType = ClefType.treble;
    objects = [
      const Clef(ClefType.treble),
      const Note(
          accidental: Accidental.sharp,
          pitch: Pitch.b4,
          noteDuration: NoteDuration.sixteenth,
          fingering: Fingering.thumb),
      const Clef(ClefType.alto),
      const Note(
          accidental: Accidental.flat,
          pitch: Pitch.c4,
          noteDuration: NoteDuration.sixteenth,
          fingering: Fingering.zero),
      const Clef(ClefType.tenor),
      const Note(
          accidental: Accidental.doubleFlat,
          pitch: Pitch.a3,
          noteDuration: NoteDuration.sixteenth,
          fingering: Fingering.zero),
      const Clef(ClefType.bass),
      const Note(
          pitch: Pitch.d3,
          noteDuration: NoteDuration.sixteenth,
          accidental: Accidental.doublesharp,
          fingering: Fingering.zero),
    ];

    super.initState();
  }

  void _onTap(MusicObjectStyle m, Offset o) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: widgets(m),
          );
        });
    setState(() {});
  }

  List<ListTile> widgets(MusicObjectStyle m) {
    if (m is Note) {
      return [
        ListTile(
          title: const Text('Up'),
          onTap: () {
            _changeNotePosition(m, isAdd: true);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Down'),
          onTap: () {
            _changeNotePosition(m, isAdd: false);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Change color'),
          onTap: () {
            _changeColor(m);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Delete'),
          onTap: () {
            _delete(m);
            Navigator.pop(context);
          },
        ),
      ];
    }
    if (m is Clef) {
      return ClefType.values
          .map((e) => ListTile(
              title: Text('$e'),
              onTap: () {
                _changeClef(m, ClefType.treble);
                Navigator.pop(context);
              }))
          .toList();
    } else {
      return [
        ListTile(
          title: const Text('Change color'),
          onTap: () {
            _changeColor(m);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Delete'),
          onTap: () {
            _delete(m);
            Navigator.pop(context);
          },
        ),
      ];
    }
  }

  void _delete(MusicObjectStyle m) {
    final index = objects.indexOf(m);
    if (index == -1) {
      print('object not found');
      return;
    }
    objects.removeAt(index);
    setState(() {});
  }

  void _changeColor(MusicObjectStyle m) {
    final index = objects.indexOf(m);
    if (index == -1) {
      print('object not found');
      return;
    }
    objects.removeAt(index);
    final newObject = m.copyWith(newColor: _newColor(m));
    objects.insert(index, newObject);
    setState(() {});
  }

  void _changeClef(Clef c, ClefType newClefType) {
    final index = objects.indexOf(c);
    if (index == -1) {
      print('object not found');
      return;
    }
    objects.removeAt(index);
    final newObject = c.copyWith(newClefType: newClefType);
    objects.insert(index, newObject);
    setState(() {});
  }

  void _changeNotePosition(Note n, {required bool isAdd}) {
    final index = objects.indexOf(n);
    if (index == -1) {
      print('object not found');
      return;
    }
    objects.removeAt(index);
    print(n.pitch);
    print(n.pitch.up);
    final newObject = isAdd
        ? n.copyWith(newPitch: n.pitch.up)
        : n.copyWith(newPitch: n.pitch.down);
    ;
    objects.insert(index, newObject);
    setState(() {});
  }

  Color _newColor(MusicObjectStyle m) =>
      m.color == Colors.black ? Colors.red : Colors.black;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final sheetMusicSize = screenSize;
    final height = sheetMusicSize.height / 2;
    final width = sheetMusicSize.width;

    return Column(children: [
      SimpleSheetMusic(
        initialClefType: initialClefType,
        margin: const EdgeInsets.all(10),
        height: height,
        width: width,
        staffs: [
          Staff([Measure(objects)]),
          // Staff([Measure(objects), Measure(objects)]),
          // Staff([Measure(objects), Measure(objects)])
        ],
        onTap: _onTap,
      ),
      SimpleSheetMusic(
        initialClefType: initialClefType,
        margin: const EdgeInsets.all(10),
        height: height,
        width: width,
        staffs: [
          Staff([Measure(objects)]),
          // Staff([Measure(objects), Measure(objects)]),
          // Staff([Measure(objects), Measure(objects)])
        ],
        onTap: _onTap,
      ),
    ]);
  }
}
