<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

A Flutter plugin for rendering sheet music on canvas.
<img src="Screenshot_1710153630.png" width="50%" style="display: block; margin: auto;">
## Features

Can express sheet musics declaratively. Support for multiple single staffs.<br>
Currently supported music symbols are
<li>clefs
<li>notes(accidentals and fingerings)
<li>barlines<br>


## Usage
```dart
musicObjects = [
    Clef(ClefType.treble),
    Note(
        pitch: Pitch.c4,
        noteDuration: NoteDuration.eighth,
        accidental: Accidental.sharp,
        fingering: Fingering.one),
    Note(
        pitch: Pitch.e4,
        noteDuration: NoteDuration.eighth,
        fingering: Fingering.two),
    Note(
        pitch: Pitch.g4,
        noteDuration: NoteDuration.eighth,
        fingering: Fingering.three),
    Note(
        pitch: Pitch.c5,
        noteDuration: NoteDuration.eighth,
        accidental: Accidental.flat,
        fingering: Fingering.four),
];
measure = Measure(musicObjects);
staff = Staff([measure]);
SimpleSheetMusic(
    initialClefType: ClefType.treble,
    staffs: [staff],
)
```

## Future plans
Currently planned additions are as follows.

<li>Time signatures<br>
<li>Rests<br>
<li>Various fonts<br>
<li>Enrich gestures<br>
<li>import from MIDI, MusicXML<br>
<li>Grand staff<br>
...
